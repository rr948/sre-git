```markdown name=README.md url=https://github.com/xjh22222228/git-manual/blob/main/README.md
<p align="center">
  <img src="media/poster.png" width="300" />
  <br />
  <b>Git Common Commands Reference Manual</b>
  <p align="center">Covers basic git commands used in development, meets daily needs</p>
  <p align="center">Easy-to-understand examples, quick start in 30 minutes</p>
  <p align="center">
    <a href="https://github.com/xjh22222228/git-manual/stargazers"><img src="https://img.shields.io/github/stars/xjh22222228/git-manual" alt="Stars Badge"/></a>
    <img src="https://img.shields.io/github/license/xjh22222228/git-manual" />
    <a href="https://hits.dwyl.com/xjh22222228/git-manual">
      <img src="https://hits.dwyl.com/xjh22222228/git-manual.svg" />
    </a>
  </p>
</p>

Note: As of October 2020, GitHub has renamed the default branch `master` to `main`.

---

# Table of Contents

- [git config Configuration](#git-config-configuration)
- [git init Initialize Repository](#git-init-initialize-repository)
- [git clone Clone Repository](#git-clone-clone-repository)
- [git remote Manage Repository](#git-remote-manage-repository)
- [git add Stage Files](#git-add-stage-files)
- [git commit Commit Files](#git-commit-commit-files)
- [git push Push to Remote](#git-push-push-to-remote)
- [git branch Create, View, Delete, Rename Branches](#git-branch-create-view-delete-rename-branches)
- [git checkout Switch, Create Branches, Restore Files](#git-checkout-switch-create-branches-restore-files)
- [git switch Switch, Create Branches](#git-switch-switch-create-branches)
- [git cherry-pick Transfer Commits](#git-cherry-pick-transfer-commits)
- [git stash Temporary Save](#git-stash-temporary-save)
- [git status File Status](#git-status-file-status)
- [git log Logs](#git-log-logs)
- [git shortlog Logs](#git-shortlog-logs)
- [git reflog Logs](#git-reflog-logs)
- [git blame Last Modified Information](#git-blame-last-modified-information)
- [git merge Merge](#git-merge-merge)
- [git rm Delete Files](#git-rm-delete-files)
- [git restore Restore](#git-restore-restore)
- [git pull Pull](#git-pull-pull)
- [git mv Move/Rename Files](#git-mv-moverename-files)
- [git diff Compare File Content Differences](#git-diff-compare-file-content-differences)
- [git show View Historical Commit Information](#git-show-view-historical-commit-information)
- [git reset Rollback Version](#git-reset-rollback-version)
- [git tag Tags](#git-tag-tags)
- [git rebase Rebase](#git-rebase-rebase)
- [git flow Workflow](#git-flow-workflow)
- [git submodule Submodules](#git-submodule-submodules)
- [git subtree Subtree](#git-subtree-subtree)
- [git bisect Binary Search](#git-bisect-binary-search)
- [git archive Archive](#git-archive-archive)
- [Clear Commit History](#clear-commit-history)
- [Help](#help)
- [Commit Convention](#commit-convention)
- [Resolve Conflicts](#resolve-conflicts)
- [Repository Migration](#repository-migration)
- [Tips and Tricks](#tips-and-tricks)
- [GUI Clients](#gui-clients)
- [Clone Repository Using SSH](#clone-repository-using-ssh)
- [Others](#others)
- [Remember Password](#remember-password)
- [Clear Account](#clear-account)
- [Acceleration](#acceleration)
- [Mind Map](#mind-map)

## git config Configuration

`git config` is a command used to configure various parameters in Git, allowing you to personalize Git's behavior and environment settings. These settings can be applied at three different levels: system, global, and repository level. Different priority levels apply - repository-level settings override global settings, which in turn override system-level settings.

#### Basic Syntax

```bash
git config [--system | --global | --local] <name> <value>
```

- `--system`: Specify system-level configuration, applies to all users and all repositories. Configuration file is typically located at `/etc/gitconfig` (Linux or macOS).
- `--global`: Specify global-level configuration, applies to the current user's all repositories. Configuration file is typically located at `~/.gitconfig` or `~/.config/git/config` (Linux or macOS).
- `--local`: Specify repository-level configuration, applies only to the current repository. Configuration file is located in `.git/config` directory of the current repository.
- If no option is specified above, `--local` is used by default.
- `<name>`: The name of the parameter to configure.
- `<value>`: The value to set for the parameter.

```bash
# View global configuration list
git config --global -l

# View current repository configuration list
git config --local -l

# View all configurations and their locations
git config --list --show-origin

# View set global username/email
git config --global --get user.name
git config --global --get user.email

# Set global username/email
git config --global user.name "xiejiahe"
git config --global user.email "example@example.com"

# Set local repository username/email in current working area
git config --local user.name "xiejiahe"
git config --local user.email "example@example.com"

# Delete configuration
git config --unset --global user.name
git config --unset --global user.email

# Change default text editor, for example nano
# Common editors: emacs / nano / vim / vi
git config --global core.editor nano

# Set default diff tool to vimdiff
git config --global merge.tool vimdiff

# Edit current repository configuration file
git config -e  # equivalent to vi .git/config

# File permission changes will be treated as modifications, ignore this with:
git config core.fileMode false

# Set file case sensitivity, git ignores case by default
git config --global core.ignorecase false

# Configure git pull to fetch all submodules by default
git config submodule.recurse true

# Remember commit account and password, next operation can be done without credentials
git config --global credential.helper store # permanent
git config --global credential.helper cache # temporary, 15 minutes by default
```

#### Command Aliases

Git can use aliases to simplify complex commands, similar to the [alias](https://github.com/xjh22222228/linux-manual#alias) command.

```bash
# git st is equivalent to git status
git config --global alias.st status

# If added before, use --replace-all to override
git config --global --replace-all alias.st status

# Execute external commands, just add ! prefix
git config --global alias.st '!echo hello';
# Adding "!" allows executing external commands to perform complex merge processes, for example:
git config --global alias.mg '!git checkout develop && git pull && git merge main && git checkout -';

# Delete st alias
git config --global --unset alias.st
```

#### Configure Proxy

```bash
# Set proxy
git config --global https.proxy  http://127.0.0.1:1087
git config --global http.proxy  http://127.0.0.1:1087

# View proxy settings
git config --global --get http.proxy
git config --global --get https.proxy

# Cancel proxy
git config --global --unset http.proxy
git config --global --unset https.proxy
```

## git init Initialize Repository

`git init [--bare] [directory]` is used to create a new Git repository in the specified directory.

`--bare`: Optional parameter to create a bare repository. Bare repositories are typically used as remote repositories, contain no working directory, and are mainly used for code sharing during multi-person collaboration.

`directory`: Optional parameter specifying the directory to initialize as a Git repository. If not specified, the repository is initialized in the current directory.

#### Use Cases

- `New project initialization`: When starting a new project, use `git init` to convert the project directory into a Git repository, facilitating version control.
- `Add existing project to version control`: If you have an existing project that hasn't used version control, use `git init` to bring it under Git management.

```bash
# Generate .git in current directory
git init

# Create in quiet mode, only print errors or warnings
git init -q

# Create a bare repository in current directory containing only files from .git
git init --bare
```

## git clone Clone Repository

#### Basic Syntax

```bash
git clone [options] <repository> [<directory>]
```

- `options`: Optional parameter to specify additional settings for the clone operation.
- `<repository>`: Required parameter specifying the address of the remote repository to clone. Can be HTTP/HTTPS or SSH protocol-based.
- `<directory>`: Optional parameter specifying the target directory name for cloning locally. If not specified, Git uses the remote repository name.

#### Common Options

- `--depth <depth>`: Perform shallow clone, only clone specified depth of commit history without complete history. This significantly reduces clone time and disk space. For example, `git clone --depth 1 <repository>` only clones the latest commit.
- `--branch <branch>` or `-b <branch>`: Specify the branch to clone. By default, Git clones the remote repository's default branch (usually `main` or `master`). For example, `git clone -b develop <repository>` clones the remote `develop` branch.
- `--single-branch`: Only clone specified branch content without other branches' history records. Used with `--branch` option, for example `git clone --single-branch --branch feature <repository>` only clones the `feature` branch.

```bash
# Clone using HTTPS protocol
git clone https://github.com/xjh22222228/git-manual.git

# Clone using SSH protocol
git clone git@github.com:xjh22222228/git-manual.git

# Clone specified branch, -b specifies branch name, actually clones all branches and switches to develop
git clone -b develop https://github.com/xjh22222228/git-manual.git

# --single-branch completely clones only specified branch
git clone -b develop --single-branch https://github.com/xjh22222228/git-manual.git

# Specify the cloned folder name
git clone https://github.com/xjh22222228/git-manual.git git-study # if followed by . creates in current directory

# Recursive clone, useful if project contains submodules
git clone --recursive https://github.com/xjh22222228/git-manual.git

# Shallow clone, clone depth 1, only clone specified branch with only last history record, usually reduces clone time and project size
git clone --depth=1 https://github.com/xjh22222228/git-manual.git
git clone --depth=1 --no-single-branch https://github.com/xjh22222228/git-manual.git # --no-single-branch also clones all other branches

# Bare clone, no working area content, cannot commit modifications, generally used to copy repositories
git clone --bare https://github.com/xjh22222228/git-manual.git

# Mirror clone, also a bare clone, differs in containing upstream registry
git clone --mirror https://github.com/xjh22222228/git-manual.git
```

#### Clone Specified Folder

Some repositories contain client, server, and other code for multiple ends, but you don't want to fully clone the entire project, only specific folders. This requires using `sparse checkout`.

To enable sparse checkout, 2 conditions must be met:

- `core.sparsecheckout` is set to true
- `.git/info/sparse-checkout` file lists directories to check out

This repository has a `media` folder for demonstration.

```bash
# 1. Create a directory and enter it
mkdir hello-git && cd hello-git

# 2. Initialize repository
git init

# 3. Set repository address
git remote add origin https://github.com/xjh22222228/git-manual.git

# 4. Enable sparse checkout functionality
git config core.sparsecheckout true

# 5. Edit .git/info/sparse-checkout file, manually create if not exist
# Or append directory paths via command
echo "media" >> .git/info/sparse-checkout

# 6. Pull content, here specify master branch
git pull origin main
```

## git remote Manage Repository

`git remote` is the command for managing remote repositories in Git, allowing you to view, add, delete, and rename remote repositories.

#### Basic Syntax

```bash
git remote [options] [command] [args]
```

- `options`: Optional parameter to specify additional command settings.
- `command`: Specify the operation command to execute.
- `args`: Parameters needed to execute the command.

```bash
# View remote repository servers, generally prints origin, default name Git gives to cloned repository servers
# Generally only displays origin unless you have multiple remote repository addresses
git remote

# Specify -v to view current remote repository address
git remote -v

# Add remote repository address, example is custom name
# After adding, you can see example via git remote
git remote add example https://github.com/xjh22222228/git-manual.git

# View specified remote repository information
git remote show example

# Rename remote repository
git remote rename oldName newName # git remote rename example simple

# Remove remote repository
git remote remove example

# Modify remote repository address, change from HTTPS to SSH
git remote set-url origin git@github.com:xjh22222228/git-manual.git

# Subsequent pushes can specify repository name
git push example

# Update remote repository information
git remote update
```

## git add Stage Files

`git add` is a fundamental and critical command in Git, mainly used to add modified or new files from the working directory to the staging area.

#### Basic Syntax

```bash
git add [options] <file>...
```

- `options`: Optional parameter to specify different adding behavior.
- `<file>`: Files or directories to add to staging area, can specify multiple files separated by spaces.

```bash
# Stage all
git add -A

# Stage specific file
git add ./README.md

# Stage all changed files in current directory
git add .

# Stage series of files
git add 1.txt 2.txt ...

# Stage all modified or deleted files, new files won't be staged
git add -u
```

#### Notes

- `.gitignore file`: git add command ignores files specified in `.gitignore` file, even with `git add .` or `git add -A`.
- `Repeated adding`: If `git add` is executed multiple times on same file, only the last addition's changes are included in commit.

## git commit Commit Files

`git commit` is the key command used to permanently save staging area content to local repository history. Through committing, you record the project's state at specific points in time, adding descriptive information for easier viewing and understanding of each change's purpose later.

#### Basic Syntax

```bash
git commit [options] [-m <message>]
```

- `options`: Optional parameter to specify different commit behavior.
- `-m <message>`: Provide brief description for this commit, `<message>` is the specific content.

```bash
# -m commit description message
git commit -m "changes log"

# When commit message is complex needing multi-line description, omit -m parameter, Git will open text editor
git commit

# Commit specific file only
git commit README.md -m "message"

# Commit and display diff changes
git commit -v

# Allow empty commit message, usually must specify -m parameter
git commit --allow-empty-message

# Rewrite last commit message, ensure current working area has no modifications
git commit --amend -m "new commit message"

# Skip verification, if tools like husky are used
git commit --no-verify -m "message"
```

#### Modify Commit Date

When executing `git commit`, git uses current default time. But sometimes you want to modify commit date, use `--date` parameter.

Format: `git commit --date="Month Day Time Year +0800" -m "init"`

Example: `git commit --date="Mar 7 21:05:20 2021 +0800" -m "init"`

**Month abbreviations:**

| Month Abbreviation | Description |
| -------- | ------ |
| Jan      | January   |
| Feb      | February  |
| Mar      | March   |
| Apr      | April   |
| May      | May   |
| Jun      | June   |
| Jul      | July   |
| Aug      | August   |
| Sep      | September   |
| Oct      | October   |
| Nov      | November |
| Dec      | December |

## git push Push to Remote

`git push` is the command to push local repository commits to the remote repository. After completing code modifications, additions, and commits locally, use `git push` to sync these changes to the remote repository.

#### Basic Syntax

```bash
git push [options] [<repository> [<refspec>...]]
```

- `options`: Optional parameter to specify additional push settings.
- `<repository>`: Optional parameter specifying remote repository name to push to, default is origin.
- `<refspec>`: Optional parameter for specifying mapping between local and remote branches, format `[+]<src>:<dst>`.

```bash
# Default push current branch
# Equivalent to git push origin, actually pushes to default repository named origin
git push

# Set upstream branch and push
# Use -u or --set-upstream option to associate local branch with remote branch during push. After this, subsequent push or pull operations can simply use git push or git pull
git push -u origin main

# Push local branch to remote branch, local branch:remote branch
git push origin <branchName>:<branchName>

# Force push, --force shorthand
git push -f

# Delete remote branch
git push origin :old-feature
git push origin --delete old-feature # or
```

## git branch Create, View, Delete, Rename Branches

`git branch` is the core command for managing branches in Git.

#### Basic Syntax

```bash
git branch [options] [branch-name] [start-point]
```

#### View Branches

```bash
# View all branches
git branch -a

# View local branches
git branch

# View remote branches
git branch -r

# View local branches associated with remote branches
git branch -vv

# View when local main branch was created
git reflog show --date=iso main

# Search branches using grep command, include keyword dev
git branch -a | grep dev

# View which branches have been merged into current branch
# This lists all branches whose changes have been merged into current branch. These branches can usually be safely deleted.
git branch --merged

# View which branches haven't been merged into current branch
git branch --no-merged
```

#### Create Branches

```bash
# Create branch
git branch new-feature

# Create branch from specified commit
git branch new-feature commit-hash

# Force create branch
git branch -f main

# Create orphan branch with no history
git checkout --orphan new-feature
```

#### Delete Branches

```bash
# Delete local merged main branch
git branch -d main

# Force delete local branch
git branch -D branch-to-delete
```

#### Rename Branches

```bash
# Rename branch
git branch -m old-branch-name new-branch-name
```

#### Add Notes to Branches

Sometimes with many branches, it's hard to tell what a branch does by name alone.

```bash
# Command
$ git config branch.{branch_name}.description note content

# Add note to hotfix/tip branch
$ git config branch.hotfix/tip.description fix details
```

## git checkout Switch, Create Branches, Restore Files

`git checkout` is an extremely common command in Git, mainly used for switching between different branches, restoring files, and creating new branches then switching to them.

#### Basic Syntax

```bash
git checkout [options] <branch>
git checkout [options] -- <file>
```

- `options`: Optional parameter to specify different operation behavior.
- `<branch>`: Target branch name to switch to.
- `<file>`: File name to restore.

#### Switch Branches

```bash
# Switch branch
git checkout <branch>

# Switch to previous branch
git checkout -
```

When using `--depth=1` during cloning, to switch other branches like dev:

```bash
git clone --depth=1 https://github.com/xjh22222228/git-manual.git

# Switch to dev branch
git remote set-branches origin 'dev'
git fetch --depth=1 origin dev
git checkout dev
```

#### Create Branches

```bash
# Create local develop branch and switch
git checkout -b develop

# Create new branch from commit hash
git checkout -b new-branch commit-hash

# Create remote branch, actually create local branch then push to remote
git checkout -b develop
git push origin develop

# Create orphan branch not inheriting parent, empty history, generally need 4+ steps
git checkout --orphan develop
git rm -rf .  # This step is optional, if really want branch with no files
git add -A && git commit -m "commit" # add and commit, otherwise branch is hidden (before this step note working area must keep one file, otherwise can't commit)
git push --set-upstream origin develop # push to remote
```

#### Restore File to Last Commit State

```bash
# -- followed by filename, restores file to last commit state
git checkout -- file.txt
```

## git switch Switch, Create Branches

`git switch` is a new command introduced in Git 2.23, aiming to simplify branch switching operations. It's a replacement for part of `git checkout` functionality, mainly for switching between different branches, making operations clearer and safer.

#### Basic Syntax

```bash
git switch [options] <branch>
git switch [options] -c <new-branch> [start-point]
```

- `options`: Optional parameter to specify different operation behavior.
- `<branch>`: Target branch name to switch to.
- `-c`: Create new branch and switch to it.
- `<new-branch>`: New branch name to create.
- `start-point`: Optional parameter specifying new branch's starting commit, defaults to current branch's latest commit.

#### Switch Branches

```bash
# Switch to develop branch
git switch develop

# Switch to previous branch
git switch -

# Force switch to develop branch, discard all local modifications
git switch -f develop

# -t, switch remote branch, if used git remote to add new repository need -t to switch
git switch -t upstream/main
```

#### Create Branches

```bash
# Create branch and switch
git switch -c newBranch

# Force create branch
git switch -C newBranch

# Create new branch from previous 3 commits
git switch -c newBranch HEAD~3

# Can also create from commit hash
git switch -c new-branch commit-hash

# --track create dev branch and associate with remote code/dev branch
git switch --track code/dev
```

## git cherry-pick Transfer Commits

`git cherry-pick` is a very practical command in Git that applies specified commits to the current branch.

#### Use Cases

- `Sync partial commits`: When you need to sync only certain commits from one branch to another, `git cherry-pick` comes in handy, without merging the entire branch.
- `Fix specific issues`: If a problem is discovered in one branch and already fixed in another, use `git cherry-pick` to apply the fix to the problematic branch.

#### Basic Usage

- `--edit|-e`: Allow editing commit message before applying commit.
- `--no-commit`: Apply commit but don't auto-create new commit, allowing manual commit later.
- `--signoff`: Add your signature to commit message, indicating responsibility for the commit.

```bash
# Single commit
git cherry-pick <commit-hash>

# Multiple consecutive commits
# <start-commit-hash> is starting commit hash, <end-commit-hash> is ending commit hash. Note starting commit not included, only applies from after starting to ending commit.
git cherry-pick <start-commit-hash>..<end-commit-hash>

# Multiple non-consecutive commits
git cherry-pick <commit-hash-1> <commit-hash-2> <commit-hash-3>
```

```bash
# Can be commit_id or branch name
# If branch name, it's the last commit
git cherry-pick <commit_id>|branch_name

# Support transferring multiple commits, produces multiple commit records
git cherry-pick <commit_id1> <commit_id2>

# Keep original author info when committing
git cherry-pick -x <commit_id>

# Re-edit commit message, otherwise applies previous commit message
git cherry-pick -e <commit_id>

# Break current operation back to initial state
git cherry-pick --abort

# When conflicts occur, solve conflicts, add to staging area with git add then execute below to continue
git cherry-pick --continue
```

## git stash Temporary Save

`git stash` is a practical command in Git that saves uncommitted modifications in current working directory (including staged and unstaged changes) so working directory returns to clean state from last commit.

Usage scenario: Suppose current branch functionality is halfway done, suddenly need to switch to other branch to fix bugs but don't want to commit (switching branches requires cleaning working area, otherwise can't switch), this is where `git stash` comes in.

```bash
# Save current working area modifications
git stash

# Add note when saving, recommend this command
git stash save "fixed #28 Bug"

# Save including files not tracked by git
git stash -u

# View current save list
git stash list

# Restore working area modifications, removes from git stash list
git stash pop # restore latest save to working area, by default restores staged changes to working area
git stash pop stash@{1} # restore specified id, viewable via git stash list
git stash pop --index # restore latest save to working area, but if staged content also restore to staging area

# Same as pop command, only difference is won't remove from save list
git stash apply

# Clear all saves
git stash clear

# Clear specified stash id, if nothing specified after drop clears latest
git stash drop stash@{0}
git stash drop  # clear latest

# View saved modifications file content
git stash show -p stash@{0}
```

## git status File Status

`git status` is very basic and commonly used in Git, shows working directory and staging area status. Via this command, see which files are modified, which added to staging area, which deleted, etc.

```bash
# Completely view file status
git status

# Output in short format
git status -s

# Ignore submodules
git status --ignore-submodules

# Show ignored files
git status --ignored
```

## git log Logs

Executing `git log` displays all commits from recent to earliest on current branch, each record contains commit hash, author, date and commit message.

```bash
# View complete commit history
git log

# View last N commits message
git log -2

# View last N commits including diff
git log -p -2

# Search from commit, can specify -i to ignore case
git log -i --grep="fix: #28"

# Search from working directory when code alert(1) was introduced
git log -S "alert(1)"

# View specific author history
git log --author=xjh22222228

# View specific file's commit history
git log README.md

# Only show merge logs
git log --merges

# Display each commit as single line, only abbreviated commit hash and message, convenient for quick viewing
git log --oneline

# View logs graphically
git log --graph --oneline

# View history in reverse order
git log --reverse

# --since and --until: show commits in time range
git log --since="2025-03-01" --until="2025-03-25"
```

#### Format Logs

When using `git log`, use `--pretty=format` to format logs.

**Common formats:**

| Parameter | Description                                                                   |
| ---- | ---------------------------------------------------------------------- |
| %H   | Full commit hash                                                       |
| %h   | Abbreviated commit hash, generally first 7 characters                                         |
| %T   | Full tree hash                                                           |
| %t   | Abbreviated tree hash                                                           |
| %an  | Author name                                                               |
| %ae  | Author email                                                               |
| %ad  | Author date, RFC2822 style: `Thu Jul 2 20:42:20 2020 +0800`                |
| %ar  | Author date, relative time: `2 days ago`                                       |
| %ai  | Author date, ISO 8601-like style: `2020-07-02 20:42:20 +0800`             |
| %aI  | Author date, ISO 8601 style: `2020-07-02T20:42:20+08:00`                  |
| %cn  | Committer name                                                             |
| %ce  | Committer email                                                             |
| %cd  | Committer date, RFC2822 style: `Thu Jul 2 20:42:20 2020 +0800`              |
| %cr  | Committer date, relative time: `2 days ago`                                     |
| %ci  | Committer date, ISO 8601-like style: `2020-07-02 20:42:20 +0800`           |
| %cI  | Committer date, ISO 8601 style: `2020-07-02T20:42:20+08:00`                |
| %d   | Reference name: (HEAD -> main, origin/main, origin/HEAD)                    |
| %D   | Reference name without `()` and newline: HEAD -> main, origin/main, origin/HEAD |
| %e   | Encoding method                                                               |
| %B   | Raw commit content                                                           |
| %C   | Custom color                                                             |

Examples:

```bash
git log -n 1 --pretty=format:"%an" # xjh22222228

git log -n 1 --pretty=format:"%ae" # xjh22222228@gmail.com

git log -n 1 --pretty=format:"%d" #  (HEAD -> main, origin/main, origin/HEAD)

# Custom output color, %C followed by color name
git log --pretty=format:"%Cgreen Author: %an"
```

## git shortlog Logs

`git shortlog` command groups commits by author and statistics each author's commit count, displaying each author's latest commit information.

```bash
# Default output grouping by contributors
git shortlog

# List committer code contribution count, print author and contribution count
git shortlog -sn

# Sort by contribution count and print message
git shortlog -n

# View contribution in email format
git shortlog -e
```

## git reflog Logs

`git reflog` command shows local repository reference update history, each record contains reference hash, operation name, commit message and time etc.

- Display all HEAD (or specified reference) movements in past time period.
- Include commits, branch switches, resets, rebases, etc., even if these commits no longer belong to any branch.
- Reference-focused, records operation history, good for emergencies and debugging.

If you execute `git reset --hard` or delete branches, certain commits become `"unreachable"`, `git log` won't show them.

```bash
# Output each commit record as single line log
git reflog

# Restore lost commits, find commit_id via git reflog
git reflog
git reset --hard commit_id

# Specify number of records displayed. For example, show last 5 records
git reflog -n 5

# Show dates in relative time (like "2 days ago")
git reflog --relative-date

# Show records in different date format. For example, iso format
git reflog --date=iso
```

#### Notes

- Records local repository operation history, won't be pushed with code to remote repository.
- Records retained 90 days (for reachable objects) or 30 days (for unreachable objects) by default, but time can be adjusted via configuration `gc.reflogExpire` and `gc.reflogExpireUnreachable`.

## git blame Last Modified Information

`git blame` is an extremely practical command in Git, main function is viewing each line's last modification information, including last modified commit hash, author, date and commit message etc.

#### Basic Syntax

```bash
git blame <filename>
```

```bash
# View README.md modification info, shows each line's modification info
git blame README.md

# View specific line numbers modification info
git blame -L 11,12 README.md
git blame -L 11 README.md   # view from line 11 onward

# Show full hash value
git blame -l README.md

# Show modified line count
git blame -n README.md

# Show author email
git blame -e README.md

# Combine parameters for query
git blame -enl -L 11 README.md

# -w ignore whitespace changes
git blame -w README.md

# Show timestamps in more readable format
git blame -c README.md
```

## git merge Merge

`git merge` is the command for merging branch modifications into current branch.

Merge `feature/v1.0.0` branch code into `develop`

```bash
git checkout develop
git merge feature/v1.0.0
```

Merge previous branch code into current branch

```bash
git merge -
```

Merge in quiet mode, merge develop into current branch with no output

```bash
git merge develop -q
```

Merge without editing message, skip interaction

```bash
git merge develop --no-edit
```

Don't commit after merge

```bash
git merge develop --no-commit
```

Exit merge, restore to state before merge

```bash
git merge --abort
```

Merge specified files or directories from branch, note this directly overwrites existing files, not a true merge.

```bash
# Merge src/utils/http.js and src/utils/load.js 2 files from dev branch into current branch
git checkout dev src/utils/http.js src/utils/load.js
```

Allow merging unrelated histories, using `--depth` during clone causes major conflicts during merge, `allow-unrelated-histories` solves this

```bash
git merge develop --allow-unrelated-histories
```

Merge with custom commit message

```bash
git merge develop -m "Merge develop branch into main"
```

## git rm Delete Files

`git rm <file>`: Remove file from working directory and index, records this removal in next commit.

```bash
# Delete 1.txt file
git rm 1.txt

# Delete all current files, unlike rm -rf doesn't delete .git directory
git rm -rf .

# Clear current working area cache, won't delete files, usually for fixing file name changes not working
git rm -r --cached .

# Remove file from index, working directory files preserved. Usually for making Git stop tracking a file
git rm --cached <file>
```

## git restore Restore

`git restore` is a command introduced in Git 2.23, mainly for restoring working area files and staging area state.

Meant to separate `git checkout` / `git reset` responsibilities.

```bash
# Undo working area file modifications, excluding new files
git restore README.md # one file
git restore README.md README2.md # multiple files
git restore . # all files in current area

# Restore from staging area to working area
git restore --staged README.md
```

## git pull Pull

`git pull` pulls latest content and merges.

#### Pull Latest Remote Branch Content

By default pulls current branch

```bash
# Conflicts auto-merge if occur
git pull
```

#### Pull Specified Branch

```bash
# remote branch:local branch
git pull origin main:main
# If certain remote branch pulled and merged to current branch, following can be omitted
git pull origin main
```

#### Pull Specified Working Directory

```bash
# By default pull into current working directory, but can specify `-C` for specific working directory
git -C /opt/work pull
```

#### Sync Forked Repository

When forking others' repository, if original changes, merge into fork repository via:

```bash
# 1. Add original remote repository: git remote add custom_name remote_repo_address
git remote add upstream https://github.com/xjh22222228/git-manual.git

# 2. Fetch latest remote branch content
git fetch --depth=1 upstream main

# 3. Merge remote latest to current branch (allow unrelated history merge)
git merge upstream/main --allow-unrelated-histories

# 4. Push to remote
git push
```

## git mv Move/Rename Files

`git mv` command renames or moves files. Most developers manually move files, but `git mv` and manual are different.

Manual vs `git mv` difference (suppose renaming `README.md` to `README2.md`):

- Manual: First delete `README.md`, then create `README2.md`, history can't be properly tracked
- `git mv`: Actually updates index, renames file, history easily retrievable

`git mv` is similar to unix `mv` command if familiar with it.

Note: New created files don't support `git mv`, must commit first.

```bash
# Rename 1.txt to 2.txt
git mv 1.txt 2.txt

# Force rename 1.txt to 2.txt, regardless if 2.txt exists
git mv -f 1.txt 2.txt

# Move directory same way
git mv temp temp2
```

## git diff Compare File Content Differences

`git diff` command views differences between `working area files` and staging area or remote.

#### git diff

```bash
# View all files differences between working area and staging area
git diff

# View specified file working area and staging area difference
git diff README.md

# View specified commit content difference
git diff dce06bd

# Compare 2 commits differences
git diff e3848eb dce06bd

# Compare 2 branches latest commits differences, develop vs main, returns empty if no difference
git diff develop main

# Compare 2 branches specified file differences, develop and main README.md file difference
git diff develop main README.md README.md

# View working area conflict file differences
git diff --name-only --diff-filter=U

# View which files changed last time
git diff --name-only HEAD~
git diff --name-only HEAD~~ # last 2 times...
```

## git show View Historical Commit Information

View historical commit information via `git show` command.

```bash
# If no parameter specified, defaults to latest info
git show

# View by specifying commit_id
git show d68a1ef

# Can also specify commit_id to view specified file commit info
git show d68a1ef README.md

# Only specify filename to view last commit containing this file
git show README.md

# Specify branch name to view last commit info
git show feature/dev
```

## git reset Rollback Version

2 rollback methods:

- `git reset` - changes commit history. After moving HEAD pointer with git reset, skipped commits may be cleaned by Git's garbage collection without other references, disappearing from commit history.
- `git revert` - doesn't delete any original commits, instead adds reverse operation commit in history. Commit history continuity preserved, all original commits remain.

`git reset` usage:

```bash
# --hard discard working area and staging area, back to current commit
git reset --hard

# Rollback previous version
git reset --hard HEAD^

# Rollback previous 2 versions
git reset --hard HEAD^^

# Rollback to specified commit_id, view via git log
git reset --hard 'commit id'

# Rollback to previous modification, default --mixed, reset staging area, working area unchanged
git reset HEAD~1

# --soft keep previous staging area and working area
git reset --soft HEAD^
```

`git revert` usage:

```bash
# Rollback last commit version
git revert HEAD^

# Rollback specified commit
git revert 8efef3d37

# --no-edit rollback and skip editing message
git revert HEAD^ --no-edit

# Break current operation, restore initial state
git revert --abort

```

## git tag Tags

```bash
# List all local tags
git tag

# List all remote tags
git ls-remote --tags origin

# Find tags with specific pattern, `*` template search
git tag -l "v1.0.0*"

# Create annotated tag
git tag -a v1.1.0 -m "tag description"

# Create lightweight tag, no parameters needed
git tag v1.1.0

# Retroactive tagging, suppose forgot to tag before, check commit id via git log
git log
git tag -a v1.1.0 <commit_id>

# Push to remote, only creates locally by default
git push origin v1.1.0

# Push all tags to remote at once
git push origin --tags

# Delete tag, need run git push origin v1.1.0 again to delete remote tag
git tag -d v1.1.0

# Delete remote tag
git push origin --delete v1.1.0

# Checkout tag
git checkout v1.1.0

# View local specific tag detailed info
git show v1.1.0
```

## git rebase Rebase

`git rebase` has 2 practical functions:

- Merge multiple commit records into one
- Replace `git merge` for merging code

### 1. Merge Multiple Commit Records Into One

Note ensure working area empty before operating.

1. Specify records to operate, enters interactive command

```bash
# start required, end optional, defaults to current branch HEAD commit
git rebase -i <start> <end>

git rebase -i HEAD~5 # operate last 5 commits
git rebase -i e88835de # or operate by commit_id
```

| Parameter | Description |
| --------- | --------------------------------------------------------------- |
| p, pick   | Keep current commit, default |
| r, reword | Keep current commit but edit commit message |
| e, edit   | Keep current commit but stop for modifications |
| s, squash | Keep current commit but merge into previous commit |
| b, break  | Stop here (later continue with `git rebase --continue`) |
| d, drop   | Delete current commit |

Listed in reverse order, latest record last

2. Change all to `s` or `squash` except first:

3. Press `:wq` exit interactive, then enter another to edit commit message, if no need to change previous message directly exit:

4. Force push to remote

```bash
# Push to main branch
git push -u -f origin main
```

### 2. Merge Branch Code

Many say use `git rebase` instead `git merge` for merging, difference is `git rebase` makes history clearer. Compare with 2 images below:

First image is `git rebase`, second is `git merge`.

Can see `git rebase` is straight line, `git merge` has crossings, hard to understand.

Suppose 2 branches exist, main and dev. Use `git rebase` merge dev into main:

```bash
# 1. First switch to main branch
git switch main

# 2. Merge dev into current main
git rebase dev

# No conflicts, directly push
git push

# Conflicts, solve conflicts => stage => continue => force push
git add -A
git rebase --continue # continue
git push -f # force push
```

Interrupt `git rebase` operation, if halfway don't want continue rebase:

```bash
$ git rebase --abort
```

## git flow Workflow

Git Flow is workflow based on git, defining strict branch creation model around project release.

`git flow` only simplifies operations, not using `git flow` works too if following workflow, manual command execution same.

`git flow` not built-in, needs separate installation.

#### Initialize

Each repository must initialize once to use, for current user basis.

```bash
# Usually directly press enter for default settings
git flow init
```

#### Start Developing New Feature

Suppose we start developing new feature like login registration, then need feature branch for independent development.

```bash
# Step one: Start new feature, name branch v1.1.0, after creating branch name is feature/v1.1.0
git flow feature start v1.1.0

# Step two: Push branch to remote, essential in team collaboration
git flow feature publish v1.1.0

# Finally: Finish feature, merges current branch into develop and deletes feature/v1.1.0, back to develop
git flow feature finish v1.1.0
```

#### Apply Patch

When need apply patch? Suppose launched feature has BUG needing fix.

hotfix patches main branch.

```bash
# Step one: Start patch branch fix_doc for doc error fix, after creating branch name is hotfix/fix_doc
git flow hotfix start fix_doc

# Step two: Push to remote, optional, need if multiple fixing BUG together
git flow hotfix publish fix_doc

# Finally: Finish patch, merges current into main and develop, deletes branch, back to develop
git flow hotfix finish fix_doc
```

#### Release

Suppose product gives new requirement completed, can choose release. Not releasing okay, but after releasing version distinction, later finding certain version's code convenient.

```bash
# Step one: Create release version v1.1.0, after creating branch name is release/v1.1.0
git flow release start v1.1.0

# Step two: Push to remote, optional
git flow release publish v1.1.0

# Finally: Merge current into main and develop, tag, delete branch, back to develop
git flow release finish v1.1.0
```

References:

- [https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/git-flow](https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/git-flow)

#### Git flow schema

![](media/git-flow.png)

---

## git submodule Submodules

`git submodule` like package management, similar `npm`, main for code reuse. Submodule use simpler than package management.

Submodule need not establish version branch managing code, because depends on main application. Establishing version branch from main application operation, once establishing new version all content locked in this branch, regardless submodule repository modifications.

#### Add Submodule

After adding submodule, find `.gitmodules` metadata file in root directory for submodule management.

```bash
git submodule add https://github.com/xjh22222228/git-manual.git # add to current directory by default
git submodule add https://github.com/xjh22222228/git-manual.git submodules/git-manual  # add to specified directory

# -b specify repository branch to add
git submodule add -b develop https://github.com/xjh22222228/git-manual.git
```

#### Delete Submodule

```bash
# 1. Directly delete submodule directory
rm -rf submodule

# 2. Edit .gitmodules file in directory, delete needed submodule

# Finally directly push
git add -A
git commit -m "delete submodule"
git push
```

#### Clone Repository With Submodules

```bash
# --recursive for recursive clone, otherwise submodule directory empty
git clone --recursive https://github.com/xjh22222228/git-manual.git

# If already cloned repository with submodules but forgot --recursive, use to initialize, fetch and checkout any nested submodules
git submodule update --init --recursive
```

#### Fix Submodule Branch

After cloning repository with submodules, find submodule branch wrong, fix with:

```bash
git submodule foreach -q --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo main)'
```

#### Update Submodule Code

Method one: Usually to update code just execute `git pull`, quite tedious.

```bash
# Recursively fetch all submodule changes, won't update submodule content
git pull

# This time need enter submodule directory update, completes one submodule update, but many submodules bothersome
cd git-manual && git pull
```

Method two: Use `git submodule update` to update submodule

```bash
# git tries update all submodules, only need specified submodule name after --remote if updating one
git submodule update --remote

# --recursive recursively all submodules, including submodules in submodules
git submodule update --init --recursive
```

Method three: Use `git pull` to update, new update pattern, needs >= 2.14

```bash
git pull --recurse-submodules
```

If bothered every git pull needs manual adding `--recurse-submodules`, configure git pull default behavior. See [Configuration](#git-config-configuration) how to configure.

Can also reference [git submodule submodule tutorial](https://www.xiejiahe.com/blog/detail/5dbceefc0bb52b1c88c30853)

## git subtree Subtree

If know `git submodule` roughly know `git subtree` purpose, basically same thing, code reuse.

Official recommends using `git subtree` instead `git submodule`.

`git subtree` advantages:

- Unlike submodule need `.gitmodules` metadata file managing
- Sub repository treated as normal directory, actually no repository concept
- Support older Git versions (even older than v1.5.2).
- Simple workflow management easy.

`git subtree` disadvantages:

- Commands overly complex, push pull bothersome
- Though replacing submodules, usage not as widespread
- Sub and main repositories mixed, history like 2 repositories records

`git subtree` usage:

```bash
git subtree add   --prefix=<prefix> <commit>
git subtree add   --prefix=<prefix> <repository> <ref>
git subtree pull  --prefix=<prefix> <repository> <ref>
git subtree push  --prefix=<prefix> <repository> <ref>
git subtree merge --prefix=<prefix> <commit>
git subtree split --prefix=<prefix> [OPTIONS] [<commit>]
```

When operating `git subtree` current working area must be empty, otherwise can't execute.

#### Add Sub Repository

- `--prefix` specify sub repository storage location
- `main` is branch name
- `--squash` usual practice not store sub repository entire history in main, can omit if needed

After adding sub repository, treated like normal files, entering sub/common directory execute `git remote -v` find no repository.

```bash
git subtree add --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash
```

#### Update Sub Repository

When remote sub repository content changes, update via:

```bash
git subtree pull --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash
```

#### Push to Sub Repository

If modified sub repository content, push this modification to sub repository

```bash
# Need first stage sub repository code in main
git add sub/common
git commit -m "sub repository modification"
# Then push
git subtree push --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash
```

#### Split

As project iterates, main repository accumulates many commits, find each `push` very slow, especially obvious on windows.

Each `push` to sub repository takes much time recalculating sub repository commits. Because each `push` recalculates, local and remote commits always different, causes git unable to solve possible conflicts.

After using `git split` command, using `git subtree push`, git only calculates split new commits.

```bash
git subtree split --prefix=sub/common --branch=main
```

#### Simplify Commands

After above practice, obvious `git subtree` too long, every operation need type long command, unbearable.

Add sub repository as remote:

```bash
# common repository name, freely define
git remote add -f common https://github.com/xjh22222228/git-manual.git
```

Need other `git subtree` commands no need type repository address:

```bash
git subtree push --prefix=sub/common common main --squash
```

Although saves repository address, commands still long.

Another solution, use aliases, for example mac or linux use [`alias`](https://github.com/xjh22222228/linux-manual#alias) command:

```bash
alias push="git subtree push --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash"
```

Can also use git built-in alias command => [command alias configuration](#command-aliases)

If front-end, add to `package.json` file:

```json
{
  "scripts": {
    "push": "git subtree push --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash"
  }
}
```

Next push execute:

```bash
npm run push or yarn push
```

## git bisect Binary Search

`git bisect` based on binary search algorithm, locates Bug-introducing commit, 4 main commands.

Extremely practical, if Bug origin commit unknown, try this.

```bash
# Start
git bisect start [endpoint] [startpoint] # confirm via git log
git bisect start HEAD 4d83cf

# Record this commit good
git bisect good

# Record this commit bad
git bisect bad

# Exit
git bisect reset
```

Reference [https://github.com/bradleyboy/bisectercise](https://github.com/bradleyboy/bisectercise)

## git archive Archive

Create archive file, compressing current project into one file. Ignores `.git` directory.

Unlike `zip` / `tar` compression, `git archive` supports archiving specific branch or commit.

**Parameters**

| Parameter | Description |
| -------- | ----------------------------------------------------------------------------------- |
| --format | Optional, specify format, tar default, supports tar and zip, inferred from --output suffix if missing |
| --output | Output to specified directory |

```bash
# Archive main branch packed as output.tar.gz in current directory
git archive --output "./output.tar.gz" main

# Archive specified commit
git archive --output "./output.tar.gz" d485a8ba9d2bcb5

# Archive as zip, no need --format because inferred from file suffix
git archive --output "./output.zip" main

# Archive one or more directories, not entire project
git archive --output "./output.zip" main src tests
```

## Clear Commit History

2 clear methods.

1. First method principle creates new branch, suppose clearing commit branch is `develop`

```bash
# 1. Create new branch
git checkout --orphan new_branch
# 2. Stage all files and commit
git add -A && git commit -m "First commit"
# 3. Delete local develop branch
git branch -D develop
# 4. Rename new_branch to develop
git branch -m develop
# 5. Force push develop to remote
git push -f origin develop
```

2. Second method update `references`, suppose resetting `main` branch

```bash
# Find first commit_id via git log
git update-ref refs/heads/main 9c3a31e68aa63641c7377f549edc01095a44c079

# Then can commit
git add .
git commit -m "first commit"
git push -f # must force push
```

## Help

```bash
# Print all git commands detailed
git help

# Print all git commands, clearer without details
git help -a

# List all configurable variables
git help -c
```

## Commit Convention

| Tag | Description |
| -------- | ------------------------ |
| feat     | This commit has new feature |
| style    | Usually code format modification |
| chore    | Build process or auxiliary tool changes |
| fix      | Fix Bug |
| docs     | Documentation modification |
| test     | Unit test changes |
| refactor | Code refactor |
| perf     | Performance optimization, experience |
| revert   | Rollback version |
| merge    | Code merge |
| typo     | Typo, like word misspelling |

**Examples:**

```bash
# Has new feature
git commit -m "feat: add xx feature"

# Code formatting
git commit -m "style: normalize Eslint"

# Modify Jenkins build process
git commit -m "chore: Update Jenkins"

# Fix Bug, recommend clear description, convenient future finding, #688 is fix certain id number
git commit -m "fix(login flicker): #688"

# Modify documentation
git commit -m "docs: git pull"

# Unit test changes
git commit -m "test: test login"

# Project code refactor
git commit -m "refactor: process module refactor"
```

## Resolve Conflicts

**Code merge/update code** often encounters conflicts.

#### Conflict Resolving Process:

1. Execute `git pull` pull code down, git auto attempts merge
2. Edit conflict files, keep local or remote code based on situation
3. Stage files and push to remote

GUI users recommend 3 tools specifically handling git conflicts:

- [meld](http://meld.sourceforge.net/install.html)
- [kdiff3](http://kdiff3.sourceforge.net/)
- Execute `git mergetool` starts default GUI during conflict

[This article specifically introduces how to use these 2 tools](https://gitguys.com/topics/merging-with-a-gui/)

## Repository Migration

Repository migration also called repository copying.

Sometimes need migrate from old to new repository. Manual only migrates files, but migrating branches, tags, history records needs copying repository.

Old repository A: https://github.com/xjh22222228/A.git
New repository B: https://github.com/xjh22222228/B.git

1. Clone old bare repository

```bash
# Clone bare repository, no working area content
git clone --bare https://github.com/xjh22222228/A.git
```

2. Mirror push to new repository

```bash
cd A
git push --mirror https://github.com/xjh22222228/B.git
```

3. Delete just cloned old repository

```bash
rm -rf A
```

4. Pull new repository

```bash
git clone https://github.com/xjh22222228/B.git
```

Besides command migration, can import repository via webpage method too.

## Tips and Tricks

**Beautify `git log`, rival GUI**

```bash
# 1. Global configure
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# 2. Execute below command, logs become intuitive
git lg

# Here provide several more patterns, choose favorite for alias configure
git config --global alias.lg "log --graph --pretty=format:'%Cred%h - %Cgreen[%an]%Creset -%C(yellow)%d%Creset %s %C(yellow)<%cr>%Creset' --abbrev-commit --date=relative"

git config --global alias.his "log --graph --decorate --oneline --pretty=format:'%Creset %s %C(magenta)in %Cred%h %C(magenta)commited by %Cgreen%cn %C(magenta)on %C(yellow) %cd %C(magenta)from %Creset %C(yellow)%d' --abbrev-commit --date=format:'%Y-%m-%d %H:%M:%S'"

git config --global alias.hist "log --graph --decorate --oneline --pretty=format:'%Cred%h - %C(bold white) %s %Creset %C(yellow)%d  %C(cyan) <%cd> %Creset %Cgreen(%cn)' --abbrev-commit --date=format:'%Y-%m-%d %H:%M:%S'"
```

## GUI Clients

Recommend several good git GUI tools, no preference order.

- Free - [Github Desktop](https://desktop.github.com/)
- Free - [Sourcetree](https://www.sourcetreeapp.com/)
- Free - [tortoiseGit](https://tortoisegit.org/)
- Free - [gitkraken](https://www.gitkraken.com/)
- Free - [gitup](https://gitup.co/)
- Free - [magit](https://github.com/magit/magit)
- Paid - [smartgit](https://www.syntevo.com/smartgit/)
- Paid - [git-fork](https://git-fork.com/)
- Paid - [tower](https://www.git-tower.com/)
- Paid - [lazygit](https://github.com/jesseduffield/lazygit)

## Clone Repository Using SSH

Clone via SSH needs first generating SSH public and private keys on computer, steps below:

1. Enter ssh

```bash
cd ~/.ssh
```

2. Replace with your GitHub email address

```bash
# -t ed25519: use Ed25519 algorithm (more modern and secure).
# -C: add comment, usually email, no relation to GitHub email
ssh-keygen -t ed25519 -C "your_email@example.com"

# Follow prompts, can directly press enter, generates ~/.ssh/id_ed25519 by default, can change name for management
```

3. View public key and add to GitHub account

[https://github.com/settings/keys](https://github.com/settings/keys)

```bash
# Output similar ssh-ed25519 AAAAC3Nza... your_email@example.com, copy entire content.
cat ~/.ssh/id_ed25519.pub
```

4. Add SSH key

```bash
ssh-add ~/.ssh/id_ed25519
```

5. Test connection

```bash
# Following info output means ssh connection successful
# Hi xxxxx! You've successfully authenticated, but GitHub does not provide shell access.
ssh -T git@github.com
```

#### Manage Multiple GitHub Accounts

If have multiple GitHub accounts, need extra `ssh config` configuration

Modify `~/.ssh/config`

```bash
vim ~/.ssh/config
```

```bash
# Host custom name, usually GitHub account named
# Account 1
Host user1
  HostName github.com
  User git
  # Modify your key file path
  IdentityFile ~/.ssh/id_ed25519

# Account 2
Host user2
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_2
```

Test connection with custom name

```bash
ssh -T git@user1
```

Clone repository

```bash
#             Host:user/repo
git clone git@user1:admin/demo.git
```

## Others

```bash
# Check git version
git --version

# Clear local git cache
git rm -r --cached .

# List files not ignored by .gitignore
git ls-files
```

## Remember Password

Using https method requires entering account and password each time. To not prompt next time:

```bash
# Temporarily remember password, 15 minutes default
git config --global credential.helper cache

# Custom remember password time, seconds unit
git config credential.helper 'cache --timeout=3600'

# Long-term remember password
git config --global credential.helper store
```

## Clear Account

Clear git saved username and password

```bash
# windows
git credential-manager uninstall

# mac / linux (any command below works)
git config --global credential.helper ""
git config --global --unset credential.helper
```

## Acceleration

Domestic clone or download versions very slow, use mirror sites below for acceleration.
Clone:

```bash
# Public repository
git clone https://ghproxy.com/https://github.com/xjh22222228/git-manual.git

# Private repository, use with Token => https://github.com/settings/tokens
git clone https://user:your_token@ghproxy.com/https://github.com/your_name/your_private_repo
```

Resource acceleration:

```bash
https://raw.githubusercontent.com/xjh22222228/git-manual/main/media/poster.png
# ↓ Replace as
https://cdn.jsdelivr.net/gh/xjh22222228/git-manual@main/media/poster.png

# Backup domains, only replace domain
# testingcf.jsdelivr.net
# img.jsdmirror.com
# gcore.jsdelivr.net
```

###### Github File/GIST/RAW Acceleration:

Use [https://www.7ed.net/](https://www.7ed.net/)

## Mind Map

![](media/map.jpg)

[⬆ Back to Top](#)
```

This is a complete English translation of the original Chinese Git manual, covering all major Git commands with detailed explanations and practical examples for quick learning.
