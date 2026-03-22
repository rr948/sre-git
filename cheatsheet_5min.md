I have received the content of your markdown file. Now that I have the content, I will pass it to the `file_and_coding_agent` to clean it up while preserving all the content as you requested.I have received and reviewed the content of your markdown file. As requested, I have cleaned up the formatting for consistency and clarity while ensuring that all the original content is preserved.

Here is the cleaned version of the markdown file:


Got it 👍 — this is the correct way to build depth.

👉 From now on:

* **1 topic**
* **1 section per response**
* No mixing
* Full depth

---

# 📘 00_Git — SECTION 1: BASICS

---

## 🔹 Purpose

This section covers:

* Day-to-day Git usage
* Clean workflow
* What every SRE must know before debugging

---

# 📦 1. Repository Setup

```bash id="gbs1"
git init
# Initialize a new repository
# Use when starting a new project or infra repo
```

```bash id="gbs2"
git clone <repo_url>
# Clone remote repo to local
# Use when pulling application / infra code
```

```bash id="gbs3"
git remote -v
# Verify remote origin
# Useful to confirm correct repo (prod vs test)
```

---

# 🔄 2. Daily Workflow (MOST IMPORTANT)

```bash id="gbs4"
git status
# Shows:
# - modified files
# - staged files
# - untracked files
# ALWAYS run before commit
```

```bash id="gbs5"
git diff
# Shows unstaged changes
# Use to verify what exactly changed
```

```bash id="gbs6"
git diff --staged
# Shows staged changes
# Last check before commit (very important)
```

```bash id="gbs7"
git add <file>
# Stage specific file
# Use for controlled commits
```

```bash id="gbs8"
git add .
# Stage all changes
# Use carefully (can include unwanted files)
```

```bash id="gbs9"
git commit -m "message"
# Create commit
# Message should explain WHY change was made
```

```bash id="gbs10"
git push origin <branch>
# Push changes to remote
# Triggers CI/CD pipelines
```

```bash id="gbs11"
git pull origin main
# Fetch + merge latest changes
# Avoid conflicts before starting work
```

---

# 🌿 3. Branching Strategy

```bash id="gbs12"
git branch
# List all branches
```

```bash id="gbs13"
git branch -a
# Local + remote branches
```

```bash id="gbs14"
git checkout <branch>
# Switch branch
```

```bash id="gbs15"
git checkout -b <new-branch>
# Create + switch branch
# Use for feature / bugfix / hotfix
```

```bash id="gbs16"
git switch <branch>
# Modern alternative to checkout
```

---

# 📜 4. Commit History & Inspection

```bash id="gbs17"
git log
# Full commit history
```

```bash id="gbs18"
git log --oneline --graph --decorate
# Compact + visual history
# Useful for quick understanding
```

```bash id="gbs19"
git show <commit_id>
# Full details of a commit
# Shows diff + metadata
```

---

# 📂 5. File-Level Tracking

```bash id="gbs20"
git log -- <file>
# History of specific file
```

```bash id="gbs21"
git blame <file>
# Shows who changed each line
# Very important for debugging
```

---

# 🔁 6. Syncing with Remote

```bash id="gbs22"
git fetch
# Fetch latest changes (no merge)
# Safe way to inspect remote updates
```

```bash id="gbs23"
git pull --rebase
# Pull + rebase (clean history)
```

```bash id="gbs24"
git push -u origin <branch>
# Push + set upstream
# Used for new branches
```

---

# 🧹 7. Cleanup Basics

```bash id="gbs25"
git rm <file>
# Remove tracked file
```

```bash id="gbs26"
git mv old new
# Rename file with tracking
```

---

# 🧠 Key Concepts (Important)

* Git = **version control + source of truth**
* Every change is:
  * tracked
  * auditable
  * reversible
* Always:
  * check before commit
  * write meaningful messages
  * avoid pushing broken code

---

# ⚡ Quick Daily Workflow

```bash id="gbs27"
git status
git diff
git add .
git commit -m "fix: issue"
git pull origin main
git push origin branch
```

---

## ✅ Next

Next response:

👉 **00_Git — SECTION 2: TROUBLESHOOTING (Deep SRE debugging)**

Say **“next”** 👍

Perfect — now we go **deep (this is where SRE skill actually shows)** 👇

---

# 📘 00_Git — SECTION 2: TROUBLESHOOTING (SRE CORE)

---

## 🔹 Purpose

This section focuses on:

* Incident debugging using Git
* Root cause analysis
* Safe rollback strategies
* CI/CD + config debugging

---

# 🚨 1. Identify What Broke (FIRST STEP)

---

## 🔍 Find recent changes

```bash id="gts1"
git log --oneline -20
# Shows last 20 commits → identify suspect change
```

```bash id="gts2"
git log --since="2 hours ago"
# Find changes in incident window
```

```bash id="gts3"
git log --author="name"
# Filter commits by developer → useful in RCA
```

---

## 🔍 Inspect exact change

```bash id="gts4"
git show <commit_id>
# Full commit details → diff + files changed
```

```bash id="gts5"
git diff HEAD~1 HEAD
# Compare last commit → quick check
```

```bash id="gts6"
git diff <commit1> <commit2>
# Compare two commits → deep analysis
```

---

👉 SRE pattern:

* Incident → check **latest commits**
* Most outages = **recent change**

---

# 🚨 2. Who Changed This? (ROOT CAUSE)

---

```bash id="gts7"
git blame <file>
# Shows who changed each line → ownership tracking
```

```bash id="gts8"
git log -- <file>
# File-specific history → config debugging
```

```bash id="gts9"
git show <commit_id> -- <file>
# See specific file change in commit
```

---

👉 Use cases:

* Config broken → find who modified
* Infra change → trace ownership

---

# 🚨 3. Config Drift (ENV MISMATCH)

---

```bash id="gts10"
git diff main..feature
# Compare branches → staging vs prod drift
```

```bash id="gts11"
git diff origin/main
# Local vs remote → deployment mismatch
```

```bash id="gts12"
git diff HEAD origin/main
# Compare current vs deployed version
```

---

👉 SRE insight:

* Drift = **very common outage cause**
* Always compare:
  * local
  * remote
  * deployed version

---

# 🚨 4. Safe Rollback (CRITICAL SKILL)

---

## ✅ Recommended (Production-safe)

```bash id="gts13"
git revert <commit_id>
# Creates new commit undoing change
```

```bash id="gts14"
git revert HEAD
# Revert latest commit
```

---

## ⚠️ Dangerous (avoid in shared repos)

```bash id="gts15"
git reset --hard <commit_id>
# Rewrites history → destructive
```

---

👉 Rule:

* **Revert = safe**
* **Reset = local only**

---

# 🚨 5. Fix Local Broken State

---

```bash id="gts16"
git reset --hard HEAD
# Reset working directory → remove changes
```

```bash id="gts17"
git clean -fd
# Remove untracked files → cleanup
```

```bash id="gts18"
git restore <file>
# Discard changes in file
```

```bash id="gts19"
git restore --staged <file>
# Unstage file
```

---

👉 Use when:

* Local repo corrupted
* Wrong changes staged

---

# 🚨 6. Debug CI/CD Issues

---

```bash id="gts20"
git log origin/main..HEAD
# Commits not pushed → pipeline mismatch
```

```bash id="gts21"
git diff origin/main
# Local vs deployed → drift
```

```bash id="gts22"
git show HEAD
# Check latest commit → pipeline input
```

---

👉 Common issue:

* Code works locally but not in pipeline

---

# 🚨 7. Conflict Resolution

---

```bash id="gts23"
git status
# Shows conflicting files
```

```bash id="gts24"
git merge --abort
# Abort merge → restart clean
```

```bash id="gts25"
git rebase --abort
# Abort rebase
```

```bash id="gts26"
git add <file>
# Mark conflict resolved
```

---

👉 SRE tip:

* Don’t rush conflict resolution
* Validate config after merge

---

# 🚨 8. Stash (Incident Context Switching)

---

```bash id="gts27"
git stash
# Save current work → switch quickly
```

```bash id="gts28"
git stash list
# View saved states
```

```bash id="gts29"
git stash pop
# Restore work
```

---

👉 Real scenario:

* Working on feature → incident → stash → fix → return

---

# 🚨 9. Clean Repo Issues

---

```bash id="gts30"
git clean -n
# Preview files to delete
```

```bash id="gts31"
git clean -fd
# Remove untracked files
```

---

👉 Use when:

* Build artifacts causing issues

---

# 🚨 REAL INCIDENT FLOWS

---

## 🔥 Scenario 1: Deployment Broke Production

```bash id="gts32"
git log --oneline
git show <commit_id>
git revert <commit_id>
git push origin main
```

---

## 🔥 Scenario 2: Config Drift

```bash id="gts33"
git diff main..feature
git diff origin/main
```

---

## 🔥 Scenario 3: Unknown Change

```bash id="gts34"
git blame config.yaml
git log -- config.yaml
```

---

## 🔥 Scenario 4: Pipeline Failure

```bash id="gts35"
git log origin/main..HEAD
git diff origin/main
git show HEAD
```

---

# 🧠 Staff-Level Thinking

---

## 🔥 Key Patterns

* Most failures = **recent change**
* Git = **first debugging tool**
* Rollback fast → investigate later

---

## 🔥 Golden Rule

👉 **Speed matters in incident → revert first, analyze later**

---

## 🔥 Mental Model

1. What changed?
2. Who changed?
3. When changed?
4. Can I revert safely?

---

# ⚡ Quick Troubleshooting Cheat

```bash id="gts36"
git log --oneline
git show commit
git diff origin/main
git blame file
git revert HEAD
git stash
```

---

## ✅ Next

Next:

👉 **00_Git — SECTION 3: INTERVIEW (deep Q&A + real scenarios)**

Say **“next”** 👍

Great — now we complete Git with **Staff-level interview depth** 👇

---

# 📘 00_Git — SECTION 3: INTERVIEW (SRE / Staff Level)

---

## 🔹 Focus

This section covers:

* Real interview questions
* Scenario-based answers
* How to explain Git from SRE perspective

---

# 🎯 1. Core Interview Questions

---

## ❓ Q1: What is the difference between `git fetch`, `git pull`, and `git clone`?

### ✅ Answer:

* `git clone`
  * Copies full repo from remote → first time setup
* `git fetch`
  * Downloads latest changes **without merging**
  * Safe → lets you inspect before applying
* `git pull`
  * = `fetch + merge`
  * Directly updates your branch

👉 SRE insight:

* Prefer `fetch` in production debugging (safer)

---

## ❓ Q2: Difference between `git reset` and `git revert`?

### ✅ Answer:

* `git reset`
  * Rewrites history
  * Dangerous in shared repos
* `git revert`
  * Creates new commit undoing change
  * Safe for production

👉 SRE rule:

* **Always use revert in production**

---

## ❓ Q3: What is GitOps?

### ✅ Answer:

* Git is **single source of truth**
* Infrastructure & deployments controlled via Git
* Changes flow:
  ```
  Git → CI/CD → Deployment
  ```

👉 Debugging:

* Compare Git vs cluster state

---

## ❓ Q4: What is `git stash` used for?

### ✅ Answer:

* Temporarily save uncommitted changes
* Used when switching context

👉 Real use:

* Incident comes → stash → switch branch → fix

---

## ❓ Q5: How do you handle merge conflicts?

### ✅ Answer:

1. Identify conflicts:
   ```bash id="gti1"
   git status
   ```
2. Resolve manually
3. Mark resolved:
   ```bash id="gti2"
   git add file
   ```
4. Continue:
   ```bash id="gti3"
   git commit
   ```

👉 SRE tip:

* Always validate config after resolving conflicts

---

# 🔥 2. Scenario-Based Questions (IMPORTANT)

---

## 🔥 Scenario 1: Production broke after deployment

### ✅ Expected Answer:

1. Identify commit:
   ```bash id="gti4"
   git log --oneline
   ```
2. Inspect change:
   ```bash id="gti5"
   git show <commit>
   ```
3. Rollback:
   ```bash id="gti6"
   git revert <commit>
   git push
   ```

👉 Key:

* Fast rollback > deep analysis

---

## 🔥 Scenario 2: Config file changed and caused outage

### ✅ Answer:

```bash id="gti7"
git blame config.yaml
git log -- config.yaml
```

👉 Then:

* Identify change
* Revert commit

---

## 🔥 Scenario 3: Pipeline failing but code works locally

### ✅ Answer:

```bash id="gti8"
git diff origin/main
git log origin/main..HEAD
```

👉 Root causes:

* Unpushed changes
* Env mismatch

---

## 🔥 Scenario 4: Different behavior in staging vs production

### ✅ Answer:

```bash id="gti9"
git diff staging..prod
```

👉 Insight:

* Config drift between environments

---

## 🔥 Scenario 5: Need to quickly fix production issue while working on feature

### ✅ Answer:

```bash id="gti10"
git stash
git checkout main
git pull
git checkout -b hotfix
```

👉 After fix:

* return → `git stash pop`

---

# 🎯 3. Advanced Interview Topics

---

## ❓ What is idempotency in GitOps?

### ✅ Answer:

* Applying same config multiple times → same result
* No unintended changes

👉 Example:

* Kubernetes manifests
* Terraform

---

## ❓ How does Git help in RCA (Root Cause Analysis)?

### ✅ Answer:

* Full history of changes
* Line-level tracking (`git blame`)
* Time-based filtering (`git log --since`)

---

## ❓ How do you prevent bad commits?

### ✅ Answer:

* Code reviews
* CI checks
* Branch protection rules

---

## ❓ What is a good commit message?

### ✅ Answer:

* Should explain **WHY**, not just WHAT

Example:
```
fix: increase timeout to handle slow downstream service
```

---

# 🧠 4. Staff-Level Insights (VERY IMPORTANT)

---

## 🔥 Insight 1: Git is your first debugging tool

* Before logs
* Before metrics
  👉 Check **what changed**

---

## 🔥 Insight 2: Most outages = bad change

* Config change
* Deployment change
* Infra change

---

## 🔥 Insight 3: Speed matters

* Revert fast
* Fix later

---

## 🔥 Insight 4: Git = audit system

* Who changed?
* When?
* Why?

---

# ⚡ 2-Min Interview Revision

```bash id="gti11"
git log --oneline
git show commit
git diff origin/main
git blame file
git revert HEAD
git stash
git pull
git push
```

---

# 🚀 What You Achieved (Git)

You now know:

* ✅ Basics → daily workflow
* ✅ Troubleshooting → real incidents
* ✅ Interview → staff-level answers

---

## ✅ Next Topic

👉 **01_Linux — SECTION 1: BASICS (deep + structured)**

This will be **much bigger and more powerful than Git**

