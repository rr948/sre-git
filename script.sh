#!/usr/bin/env bash
# Linux SRE Command Lab
# Safe, interactive practice for Ubuntu/Debian and RHEL/Rocky/Alma-like Linux.
set -u

LAB_ROOT="${TMPDIR:-/tmp}/linux-sre-lab"
PIDS="$LAB_ROOT/pids"
LOG="$LAB_ROOT/lab.log"
mkdir -p "$LAB_ROOT" "$PIDS"
touch "$LOG"

say(){ printf '\n\033[1;36m%s\033[0m\n' "$*"; }
warn(){ printf '\033[1;33m%s\033[0m\n' "$*"; }
run(){ printf '\n$ %s\n' "$*" | tee -a "$LOG"; bash -c "$*" 2>&1 | tee -a "$LOG" || true; }
pause(){ read -r -p $'\nPress Enter to continue...'; }

have(){ command -v "$1" >/dev/null 2>&1; }

install_prereqs(){
  say "Detecting OS and installing useful SRE tools"
  if [[ -r /etc/os-release ]]; then . /etc/os-release; fi
  if have apt-get; then
    run "sudo apt-get update"
    run "sudo apt-get install -y procps sysstat iproute2 iputils-ping dnsutils curl wget traceroute mtr-tiny tcpdump netcat-openbsd lsof strace jq openssl util-linux psmisc iotop-ng"
  elif have dnf; then
    run "sudo dnf install -y procps-ng sysstat iproute iputils bind-utils curl wget traceroute mtr tcpdump nmap-ncat lsof strace jq openssl util-linux psmisc iotop || true"
  elif have yum; then
    run "sudo yum install -y procps-ng sysstat iproute iputils bind-utils curl wget traceroute mtr tcpdump nc lsof strace jq openssl util-linux psmisc iotop || true"
  else
    warn "Unsupported package manager. Install procps, sysstat, iproute2, dns tools, curl, mtr, tcpdump, lsof, strace, jq and openssl manually."
  fi
}

system_info(){
  say "SYSTEM / HOST"
  run "date"; run "hostname"; run "uname -a"; run "uptime"
  run "cat /etc/os-release 2>/dev/null || true"
  run "lscpu | head -40"; run "free -h"; run "lsblk"; run "df -h"; run "df -i"; run "findmnt | head -30"
}

cpu(){
  say "CPU TROUBLESHOOTING"
  run "uptime"; run "nproc"; run "lscpu | head -35"
  run "top -b -n1 | head -30"; run "vmstat 1 3"
  have mpstat && run "mpstat -P ALL 1 2"
  have pidstat && run "pidstat -u 1 2"
  run "ps aux --sort=-%cpu | head -15"
}

memory(){
  say "MEMORY / OOM"
  run "free -h"; run "vmstat 1 3"
  have pidstat && run "pidstat -r 1 2"
  run "ps aux --sort=-%mem | head -15"
  run "grep -E 'MemTotal|MemFree|MemAvailable|Buffers|Cached|Swap' /proc/meminfo"
  run "swapon --show || true"
  run "dmesg 2>/dev/null | grep -Ei 'oom|killed process' | tail -20 || true"
}

disk(){
  say "DISK / INODES / I/O"
  run "df -h"; run "df -i"; run "lsblk -f"; run "findmnt | head -40"
  run "du -xhd1 '$LAB_ROOT' 2>/dev/null | sort -h"
  have iostat && run "iostat -xz 1 2"
  have pidstat && run "pidstat -d 1 2"
  run "lsof +L1 2>/dev/null | head -20 || true"
}

network(){
  say "NETWORK / SOCKETS"
  run "ip addr"; run "ip -s link"; run "ip route"; run "ip neigh"
  run "ss -s"; run "ss -tulpn | head -40"
  run "ping -c 3 127.0.0.1"
  run "curl -I --max-time 5 https://example.com || true"
}

dns(){
  say "DNS"
  run "cat /etc/resolv.conf"
  run "getent hosts localhost"
  have dig && run "dig +short example.com"
  have nslookup && run "nslookup example.com"
}

logs_services(){
  say "SYSTEMD / LOGS"
  if have systemctl; then
    run "systemctl --failed --no-pager || true"
    run "systemctl list-units --type=service --state=running --no-pager | head -30"
  fi
  have journalctl && run "journalctl -p err -n 30 --no-pager || true"
  run "dmesg -T 2>/dev/null | tail -40 || true"
}

text_tools(){
  say "TEXT / LOG ANALYSIS"
  cat > "$LAB_ROOT/app.log" <<EOF
INFO request=1001 status=200 latency=25ms
WARN request=1002 status=429 latency=40ms
ERROR request=1003 status=500 latency=950ms
INFO request=1004 status=200 latency=20ms
ERROR request=1005 status=503 latency=1200ms
EOF
  run "cat '$LAB_ROOT/app.log'"
  run "grep -nE 'ERROR|WARN' '$LAB_ROOT/app.log'"
  run "awk '{print \$2,\$3,\$4}' '$LAB_ROOT/app.log'"
  run "grep ERROR '$LAB_ROOT/app.log' | wc -l"
  run "awk '{print \$3}' '$LAB_ROOT/app.log' | sort | uniq -c"
}

high_cpu_lab(){
  say "LAB: HIGH CPU"
  warn "Creates one CPU-consuming process owned by this lab."
  yes >/dev/null & local p=$!; echo "$p" > "$PIDS/cpu"
  sleep 2
  run "ps -p $p -o pid,ppid,%cpu,%mem,stat,cmd"
  run "top -b -n1 -p $p | head -20"
  have pidstat && run "pidstat -u -p $p 1 3"
  kill "$p" 2>/dev/null || true; rm -f "$PIDS/cpu"
  say "CPU process stopped."
}

memory_lab(){
  say "LAB: CONTROLLED MEMORY ALLOCATION"
  warn "Allocates about 100 MiB only; it does NOT intentionally trigger the OOM killer."
  python3 -c 'import time; x=bytearray(100*1024*1024); time.sleep(20)' &
  local p=$!; echo "$p" > "$PIDS/memory"; sleep 2
  run "ps -p $p -o pid,ppid,%cpu,%mem,rss,vsz,stat,cmd"
  run "grep -E 'VmRSS|VmSize|VmPeak' /proc/$p/status || true"
  run "free -h"
  kill "$p" 2>/dev/null || true; rm -f "$PIDS/memory"
}

disk_lab(){
  say "LAB: DISK SPACE"
  warn "Creates only a 100 MiB file under $LAB_ROOT, not a real disk-full condition."
  run "dd if=/dev/zero of='$LAB_ROOT/bigfile.bin' bs=1M count=100 status=progress"
  run "ls -lh '$LAB_ROOT/bigfile.bin'"
  run "du -sh '$LAB_ROOT'"
  run "df -h '$LAB_ROOT'"
  rm -f "$LAB_ROOT/bigfile.bin"
}

inode_lab(){
  say "LAB: MANY FILES / INODE OBSERVATION"
  mkdir -p "$LAB_ROOT/inodes"
  warn "Creates 2,000 tiny files, then removes them."
  for i in $(seq 1 2000); do : > "$LAB_ROOT/inodes/f$i"; done
  run "find '$LAB_ROOT/inodes' -type f | wc -l"
  run "df -i '$LAB_ROOT'"
  rm -rf "$LAB_ROOT/inodes"
}

io_lab(){
  say "LAB: DISK I/O"
  warn "Writes a temporary 128 MiB file."
  dd if=/dev/zero of="$LAB_ROOT/io.bin" bs=1M count=128 conv=fdatasync status=none &
  local p=$!; echo "$p" > "$PIDS/io"
  have pidstat && run "pidstat -d -p $p 1 3"
  wait "$p" 2>/dev/null || true
  rm -f "$LAB_ROOT/io.bin" "$PIDS/io"
}

fd_lab(){
  say "LAB: FILE DESCRIPTORS"
  python3 - "$LAB_ROOT" <<'PY' &
import os,sys,time
root=sys.argv[1]
fds=[]
for i in range(100):
    p=os.path.join(root,f"fd-{i}.tmp")
    fds.append(open(p,"w"))
time.sleep(20)
PY
  local p=$!; echo "$p" > "$PIDS/fd"; sleep 2
  run "ls /proc/$p/fd | wc -l"
  run "cat /proc/$p/limits | grep -i 'open files'"
  have lsof && run "lsof -p $p | head -30"
  kill "$p" 2>/dev/null || true
  rm -f "$LAB_ROOT"/fd-*.tmp "$PIDS/fd"
}

zombie_lab(){
  say "LAB: ZOMBIE PROCESS"
  python3 - <<'PY' &
import os,time
p=os.fork()
if p==0:
    os._exit(0)
time.sleep(20)
PY
  local parent=$!; echo "$parent" > "$PIDS/zombie"; sleep 2
  run "ps -eo pid,ppid,state,cmd | awk '\$3 ~ /^Z/ {print}'"
  kill "$parent" 2>/dev/null || true; wait "$parent" 2>/dev/null || true
  rm -f "$PIDS/zombie"
}

port_lab(){
  say "LAB: LOCAL APPLICATION / PORT"
  local port=18080
  (cd "$LAB_ROOT" && python3 -m http.server "$port" >/dev/null 2>&1) &
  local p=$!; echo "$p" > "$PIDS/http"; sleep 2
  run "ss -lntp | grep ':$port' || true"
  run "curl -v --max-time 3 http://127.0.0.1:$port/"
  have nc && run "nc -vz 127.0.0.1 $port"
  kill "$p" 2>/dev/null || true; rm -f "$PIDS/http"; sleep 1
  run "curl --max-time 2 http://127.0.0.1:$port/ || true"
  say "The final failure is intentional: the lab server was stopped."
}

tls_lab(){
  say "LAB: TLS / CERTIFICATE INSPECTION"
  run "openssl version"
  run "echo | openssl s_client -connect example.com:443 -servername example.com 2>/dev/null | openssl x509 -noout -subject -issuer -dates || true"
}

strace_lab(){
  say "LAB: STRACE"
  if have strace; then
    run "strace -c ls '$LAB_ROOT'"
    run "strace -e trace=file ls '$LAB_ROOT' 2>&1 | head -40"
  else warn "strace is not installed."; fi
}

safe_all(){
  system_info; cpu; memory; disk; network; dns; logs_services; text_tools
}

cleanup(){
  say "CLEANUP"
  if [[ -d "$PIDS" ]]; then
    for f in "$PIDS"/*; do
      [[ -f "$f" ]] || continue
      p="$(cat "$f" 2>/dev/null || true)"
      [[ "$p" =~ ^[0-9]+$ ]] && kill "$p" 2>/dev/null || true
    done
  fi
  rm -rf "$LAB_ROOT"
  say "Lab resources removed."
}

trap 'warn "Interrupted. Use menu option 21 to clean up if needed."' INT

while true; do
  cat <<'MENU'

============================================================
                 LINUX SRE COMMAND LAB
============================================================
 1. Install/check prerequisites
 2. System / host information
 3. CPU troubleshooting
 4. Memory / OOM troubleshooting
 5. Disk / inode / I/O troubleshooting
 6. Network / sockets
 7. DNS
 8. systemd / journal / kernel logs
 9. Text and log analysis
10. Run all SAFE diagnostic commands

11. LAB - High CPU
12. LAB - Memory allocation
13. LAB - Disk-space observation
14. LAB - Inode observation
15. LAB - Disk I/O
16. LAB - File descriptors
17. LAB - Zombie process
18. LAB - Local app / port failure
19. LAB - TLS certificate inspection
20. LAB - strace
21. Cleanup
 0. Exit
============================================================
MENU
  read -r -p "Select: " choice
  case "$choice" in
    1) install_prereqs;; 2) system_info;; 3) cpu;; 4) memory;;
    5) disk;; 6) network;; 7) dns;; 8) logs_services;; 9) text_tools;;
    10) safe_all;; 11) high_cpu_lab;; 12) memory_lab;; 13) disk_lab;;
    14) inode_lab;; 15) io_lab;; 16) fd_lab;; 17) zombie_lab;;
    18) port_lab;; 19) tls_lab;; 20) strace_lab;; 21) cleanup;;
    0) say "Exiting. Lab data remains in $LAB_ROOT until cleanup."; exit 0;;
    *) warn "Invalid selection.";;
  esac
  pause
done