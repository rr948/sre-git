<p align="center">
<img src="media/poster.png" width="300" />
<br />
<b>Git Common Commands Reference Manual</b>
<p align="center">Comprehensively covers the Git commands used in software development, meeting all your daily needs.</p>
<p align="center">Features clear and easy-to-understand examples—get up to speed in just 30 minutes.</p>
<p align="center">
<a href="https://github.com/xjh22222228/git-manual/stargazers"><img src="https://img.shields.io/github/stars/xjh22222228/git-manual" alt="Stars Badge"/></a>
<img src="https://img.shields.io/github/license/xjh22222228/git-manual" />
<a href="https://hits.dwyl.com/xjh22222228/git-manual">
<img src="https://hits.dwyl.com/xjh22222228/git-manual.svg" />
</a>
</p>
</p>

Note: In October 2020, GitHub renamed the default branch from `master` to `main`. ---

# Table of Contents

- [git config: Configuration](#git-config-configuration)
- [git init: Initialize Repository](#git-init-initialize-repository)
- [git clone: ​​Clone Repository](#git-clone-clone-repository)
- [git remote: Manage Remotes](#git-remote-manage-remotes)
- [git add: Stage Files](#git-add-stage-files)
- [git commit: Commit Files](#git-commit-commit-files)
- [git push: Push to Remote](#git-push-push-to-remote)
- [git branch: Create, View, Delete, and Rename Branches](#git-branch-create-view-delete-and-rename-branches)
- [git checkout: Switch Branches, Create Branches, and Restore Files](#git-checkout-switch-branches-create-branches-and-restore-files)
- [git switch: Switch and Create Branches](#git-switch-switch-and-create-branches)
- [git cherry-pick: Transfer Commits](#git-cherry-pick-transfer-commits)
- [git stash: Temporarily Save Changes](#git-stash-temporarily-save-changes)
- [git status: File Status](#git-status-file-status)
- [git log: Commit Logs](#git-log-commit-logs)
- [git shortlog: Summarized Logs](#git-shortlog-summarized-logs)
- [git reflog: Reference Logs](#git-reflog-reference-logs)
- [git blame: Last Modified Information](#git-blame-last-modified-information)
- [git merge: Merge Branches](#git-merge-merge-branches)
- [git rm: Delete Files](#git-rm-delete-files)
- [git restore: Restore Files](#git-restore-restore-files)
- [git pull: Pull from Remote](#git-pull-pull-from-remote)
- [git mv: Move/Rename Files](#git-mv-move-rename-files)
- [git diff: Compare File Content Differences](#git-diff-compare-file-content-differences)
- [git show: View Historical Commit Information](#git-show-view-historical-commit-information)
- [git reset: Rollback Versions](#git-reset-rollback-versions)
- [git tag: Tags](#git-tag-tags)
- [git rebase: Rebase Branches](#git-rebase-rebase-branches)
- [git flow - [Git Flow Workflow](#git-flow-workflow)
- [Git Submodules](#git-submodules)
- [Git Subtree](#git-subtree)
- [Git Bisect](#git-bisect)
- [Git Archive](#git-archive)
- [Clearing Commit History](#clearing-commit-history)
- [Help](#help)
- [Commit Conventions](#commit-conventions)
- [Resolving Conflicts](#resolving-conflicts)
- [Repository Migration](#repository-migration)
- [Tips and Tricks](#tips-and-tricks)
- [GUI Clients](#gui-clients)
- [Cloning Repositories via SSH](#cloning-repositories-via-ssh)
- [Miscellaneous](#miscellaneous)
- [Remembering Passwords](#remembering-passwords)
- [Clearing Credentials](#clearing-credentials)
- [Speed ​​Optimization](#speed-optimization)
- [Mind Map](#mind-map)

## Git Config

`git config` is the Git command used to configure various parameters, allowing you to personalize Git's behavior and environment. These settings can be categorized into three distinct levels: system, global, and repository. These levels have different priorities: repository-level settings override global-level settings, while global-level settings override system-level settings.

#### Basic Syntax

```bash
git config [--system | --global | --local] <name> <value>
```

- `--system`: Specifies system-level configuration, which applies to all repositories for all users. The configuration file is typically located at `/etc/gitconfig` (on Linux or macOS).
- `--global`: Specifies global-level configuration, which applies to all repositories for the current user. The configuration file is typically located at `~/.gitconfig` or `~/.config/git/config` (on Linux or macOS).
- `--local`: Specifies repository-level configuration, which applies only to the current repository. The configuration file is located within the `.git/config` directory of the current repository.
- If none of the above options are specified, `--local` is used by default.
- `<name>`: The name of the parameter to be configured.
- `<value>`: The value to be assigned to the parameter. ```bash
# View the list of global configurations
git config --global -l

# View the list of configurations for the current repository
git config --local -l

# View all configurations along with the files where they are defined
git config --list --show-origin

# View the currently set global username/email
git config --global --get user.name
git config --global --get user.email

# Set the global username/email
git config --global user.name "xiejiahe"
git config --global user.email "example@example.com"

# Set the local username/email for the current working repository
git config --local user.name "xiejiahe"
git config --local user.email "example@example.com"

# Unset (delete) a configuration
git config --unset --global user.name
git config --unset --global user.email

# Change the default text editor (e.g., to nano)
# Common editors: emacs / nano / vim / vi
git config --global core.editor nano

# Set the default diff tool to vimdiff
git config --global merge.tool vimdiff

# Edit the configuration file for the current repository
git config -e  # Equivalent to: vi .git/config

# Changes in file permissions are treated as modifications by default;
# use the following configuration to ignore file permission changes:
git config core.fileMode false

# Make filename case-sensitivity active (Git ignores case by default)
git config --global core.ignorecase false

# Configure `git pull` to fetch all submodule content by default
git config submodule.recurse true

# Cache credentials (username/password) for commits/pushes,
# allowing future operations without re-entering them
git config --global credential.helper store # Permanent storage
git config --global credential.helper cache # Temporary cache (defaults to 15 minutes)
```

#### Command Aliases

Git allows the use of aliases to simplify complex commands, similar to the [alias](https://github.com/xjh22222228/linux-manual#alias) command. ```bash
# git st is equivalent to git status
git config --global alias.st status

# If the alias was previously defined, you must add --replace-all to overwrite it
git config --global --replace-all alias.st status

# To execute external commands, simply prefix the command with '!'
git config --global alias.st '!echo hello';
# By adding '!', you can execute external commands to perform complex merge operations; for example:
git config --global alias.mg '!git checkout develop && git pull && git merge main && git checkout -';

# Delete the 'st' alias
git config --global --unset alias.st
```

#### Configuring a Proxy

```bash
# Set the proxy
git config --global https.proxy  http://127.0.0.1:1087
git config --global http.proxy  http://127.0.0.1:1087

# View the current proxy settings
git config --global --get http.proxy
git config --global --get https.proxy

# Unset (remove) the proxy
git config --global --unset http.proxy
git config --global --unset https.proxy
```

## git init: Initializing a Repository

`git init [--bare] [directory]` is used to create a new Git repository within a specified directory.

`--bare`: An optional argument used to create a "bare" repository. Bare repositories typically serve as remote repositories; they do not contain a working directory and are primarily used for sharing code during collaborative development.

`directory`: An optional argument specifying the directory where the Git repository should be initialized. If omitted, the repository will be initialized in the current directory.

#### Use Cases

- `Initializing a New Project`: When starting a new project, you can use the `git init` command to convert the project directory into a Git repository, thereby enabling easy version control for the project.
- `Bringing an Existing Project Under Version Control`: If you have an existing project that has not yet utilized version control, you can use the `git init` command to bring it under Git's management. ```bash
# Creates a .git directory in the current directory
git init

# Creates in quiet mode; only prints error or warning messages
git init -q

# Creates a bare repository in the current directory, containing only the files found within the .git directory
git init --bare
```

## git clone: ​​Cloning a Repository

#### Basic Syntax

```bas
```
git clone [options] <repository> [<directory>]
```

- `options`: Optional arguments used to specify additional settings for the cloning operation.
- `<repository>`: A required argument specifying the address of the remote repository to be cloned. This address can be based on the HTTP/HTTPS protocol or the SSH protocol.
- `<directory>`: An optional argument specifying the name of the local target directory for the clone. If not specified, Git will use the name of the remote repository as the local directory name.

#### Common Options

- `--depth <depth>`: Performs a shallow clone, cloning only the commit history up to the specified depth rather than the complete history. This can significantly reduce the time and disk space required for the clone. For example, `git clone --depth 1 <repository>` clones only the most recent commit.
- `--branch <branch>` or `-b <branch>`: Specifies the branch to be cloned. By default, Git clones the remote repository's default branch (typically `main` or `master`). For example, `git clone -b develop <repository>` clones the `develop` branch of the remote repository.
- `--single-branch`: Clones only the content of the specified branch, excluding the history of other branches. This is used in conjunction with the `--branch` option; for example, `git clone --single-branch --branch feature <repository>` will clone only the `feature` branch. ```bash
# Clone via HTTPS protocol
git clone https://github.com/xjh22222228/git-manual.git

# Clone via SSH protocol
git clone git@github.com:xjh22222228/git-manual.git

# Clone a specific branch; -b specifies the branch name. (Note: This actually clones all branches and then switches to the 'develop' branch.)
git clone -b develop https://github.com/xjh22222228/git-manual.git

# --single-branch: Clone *only* the specified branch (excluding all others).
git clone -b develop --single-branch https://github.com/xjh22222228/git-manual.git

# Specify the name of the destination folder after cloning
git clone https://github.com/xjh22222228/git-manual.git git-study # If the destination is '.', it creates the repository in the current directory.

# Recursive clone: ​​Very useful if the project contains submodules.
git clone --recursive https://github.com/xjh22222228/git-manual.git

# Shallow clone: ​​Sets the clone depth to 1. It clones only the specified branch and retains only the most recent commit in the history. Typically used to reduce cloning time and project size.
git clone --depth=1 https://github.com/xjh22222228/git-manual.git
git clone --depth=1 --no-single-branch https://github.com/xjh22222228/git-manual.git # --no-single-branch: Clone all other branches as well (while still keeping the depth at 1).


# Bare clone: ​​Contains no working directory content; you cannot make commits or modifications directly within it. Generally used for copying repositories.
git clone --bare https://github.com/xjh22222228/git-manual.git

# Mirror clone: ​​Also a bare clone, but differs in that it includes the registration of the upstream repository (remote tracking references).
git clone --mirror https://github.com/xjh22222228/git-manual.git
``` Cloning Specific Folders

Some repositories contain code for multiple platforms—such as client-side, server-side, etc.—but you may not wish to clone the entire project; instead, you might only want to clone a specific folder. In such cases, you need to use "Sparse Checkout."

Enabling Sparse Checkout requires satisfying two conditions:

- `core.sparsecheckout` must be set to `true`.
- The `.git/info/sparse-checkout` file must list the directories you wish to check out.

This repository contains a `media` folder; let's use it for this demonstration.

```bash
# 1. Create a directory and navigate into it
mkdir hello-git && cd hello-git

# 2. Initialize the repository
git init

# 3. Set the repository URL
git remote add origin https://github.com/xjh22222228/git-manual.git

# 4. Enable the Sparse Checkout feature
git config core.sparsecheckout true

# 5. Edit the .git/info/sparse-checkout file (it does not exist by default, so you must create it manually)
# Alternatively, you can use a command to append the path of the directory you wish to check out
echo "media" >> .git/info/sparse-checkout

# 6. Pull the content (here, we specify the 'main' branch)
git pull origin main
```

<details>
<summary>Demo: Cloning a Specific Folder (.gif)</summary>

<img src="media/gitclone-sparsecheckout.gif">
</details>

## `git remote`: Managing Repositories

`git remote` is the Git command used for managing remote repositories. With it, you can perform operations such as viewing, adding, deleting, and renaming remote repositories.

#### Basic Syntax

```bash
git remote [options] [command] [args]
```

- `options`: Optional parameters used to specify additional settings for the command.
- `command`: Specifies the specific operation to be performed.
- `args`: Arguments required to execute the command. ```bash
# View remote repository servers; typically, this prints "origin," which is the default name Git assigns to the repository server you cloned from.
# Usually, only "origin" is displayed, unless you have configured multiple remote repository URLs.
git remote

# Use the -v flag to view the URLs associated with the current remote repositories.
git remote -v

# Add a remote repository URL (where "example" is a custom name you choose).
# After adding it, you can run `git remote` to see "example" listed among your remotes.
git remote add example https://github.com/xjh22222228/git-manual.git

# View detailed information about a specific remote repository.
git remote show example

# Rename a remote repository.
git remote rename oldName newName # e.g., git remote rename example simple

# Remove a remote repository.
git remote remove example

# Change the URL of a remote repository (e.g., switching from HTTPS to SSH).
git remote set-url origin git@github.com:xjh22222228/git-manual.git

# For subsequent pushes, you can specify the name of the target repository.
git push example

# Update information about the remote repositories.
git remote update
```

## git add: Staging Files

`git add` is a fundamental and critical command in Git, primarily used to move modified or newly created files from the working directory into the staging area.

#### Basic Syntax

```bash
git add [options] <file>...
```

- `options`: Optional arguments used to specify different behaviors for the add operation.
- `<file>`: The specific file(s) or directory/directories to be added to the staging area; multiple items can be specified, separated by spaces.

```bash
# Stage all changes (including new, modified, and deleted files).
git add -A

# Stage a specific file.
git add ./README.md

# Stage all changes within the current directory.
git add .

# Stage a specific set of files.
git add 1.txt 2.txt ...

# Stage all modified or deleted files; newly created files will *not* be staged.
git add -u
```

#### Important Notes

- `.gitignore` files: The `git add` command ignores files and directories specified in the `.gitignore` file; even when using commands like `git add .` or `git add -A`, these ignored files will not be added to the staging area. - `Duplicate Additions`: If you execute the `git add` command multiple times on the same file, only the changes from the *last* addition will be included in the commit.

## `git commit`: Committing Files

`git commit` is a key command in Git used to permanently save the contents of the staging area into the local repository's history. By committing, you record the state of your project at a specific point in time, while also adding descriptive information that makes it easier to review and understand the purpose of each change later on.

#### Basic Syntax

```bash
git commit [options] [-m <message>]
```

- `options`: Optional parameters used to specify different commit behaviors.
- `-m <message>`: Used to provide a brief descriptive message for the current commit; `<message>` represents the actual content of the description.

```bash
# -m: The commit description message
git commit -m "changes log"

# If the commit message is complex and requires multiple lines, you can omit the -m parameter; Git will default to opening a text editor for you to enter the commit message.
git commit

# Commit only a specific file
git commit README.md -m "message"

# Commit and display the diff (changes)
git commit -v

# Allow committing with an empty message (typically, the -m parameter is required)
git commit --allow-empty-message

# Rewrite the previous commit message (ensure there are no uncommitted changes in your working directory)
git commit --amend -m "New commit message"

# Skip verification (useful if you are using tools like Husky)
git commit --no-verify -m "message"
```

#### Modifying the Commit Date

When you execute `git commit`, Git uses the current system time by default; however, if you wish to modify the commit date, you can use the `--date` parameter. Format: `git commit --date="Month Day Time Year +0800" -m "init"`

Example: `git commit --date="Mar 7 21:05:20 2021 +0800" -m "init"`

**Month abbreviations are as follows:**

| Abbreviation | Description |
|--------------|-------------|
| Jan          | January     |
| Feb          | February    |
| Mar          | March       |
| Apr          | April       |
| May          | May         |
| Jun          | June        |
| Jul          | July        |
| Aug          | August      |
| Sep          | September   |
| Oct          | October     |
| Nov          | November    |
| Dec          | December    |

## `git push`: Pushing to a Remote Repository

`git push` is the Git command used to push commits from your local repository to a remote repository. Once you have completed a series of code modifications, additions, and commits locally, you can use `git push` to synchronize these changes to the remote repository.

#### Basic Syntax

```bash
git push [options] [<repository> [<refspec>...]]
```

- `options`: Optional parameters, used to specify push...
Additional settings for the push operation:
- `<repository>`: An optional argument specifying the name of the remote repository to push to; the default is `origin`.
- `<refspec>`: An optional argument used to specify the mapping relationship between a local branch and a remote branch, in the format `[+]<src>:<dst>`.

```bash
# Push the current branch by default
# Equivalent to `git push origin`; effectively pushes to the default repository named `origin`.
git push

# Set the upstream branch and push
# Use the `-u` or `--set-upstream` option to associate the local branch with the remote branch while pushing. Subsequently, when performing push or pull operations on this branch, you can simply use `git push` or `git pull` without needing to specify the remote repository or branch name again.
git push -u origin main

# Push a local branch to a remote branch (format: local-branch:remote-branch)
git push origin <branchName>:<branchName>

# Force push (abbreviation for --force)
git push -f

# Delete a remote branch
git push origin :old-feature
git push origin --delete old-feature # Alternatively
```

## `git branch`: Create, View, Delete, and Rename Branches

`git branch` is a core Git command used for managing branches.

#### Basic Syntax

```bash
git branch [options] [branch-name] [start-point]
```

#### Viewing Branches

```bash
# View all branches (local and remote)
git branch -a

# View local branches
git branch

# View remote branches
git branch -r

# View local branches along with their associated remote branches
git branch -vv

# Check the creation time of the local 'main' branch
git reflog show --date=iso main

# Search for branches (using the `grep` command to search for the keyword 'dev')
git branch -a | grep dev

# View which branches have already been merged into the current branch
# This command lists all branches whose changes have already been merged into the current branch. Typically, these branches can be safely deleted.
``` git branch --merged

# View which branches have not yet been merged into the current branch
git branch --no-merged
```

#### Creating Branches

```bash
# Create a branch
git branch new-feature

# Create a branch from a specific commit
git branch new-feature commit-hash

# Force-create a branch
git branch -f main

# Create an orphan branch (with no history)
git checkout --orphan new-feature
```

#### Deleting Branches

```bash
# Delete a local branch that has already been merged (e.g., main)
git branch -d main

# Force-delete a local branch
git branch -D branch-to-delete
```

#### Renaming Branches

```bash
# Rename a branch
git branch -m old-branch-name new-branch-name
```

#### Adding Descriptions to Branches

Sometimes, having too many branches makes it difficult to determine the purpose of a specific branch based solely on its name.

```bash
# Command syntax
$ git config branch.{branch_name}.description "Description content"

# Add a description to the hotfix/tip branch
$ git config branch.hotfix/tip.description "Details of the fix"
```

## `git checkout`: Switching Branches, Creating Branches, and Restoring Files

`git checkout` is an extremely common command in Git. It is primarily used to switch between different branches, restore files, and create a new branch while simultaneously switching to it.

#### Basic Syntax

```bash
git checkout [options] <branch>
git checkout [options] -- <file>
```

- `options`: Optional parameters used to specify different operational behaviors.
- `<branch>`: The name of the branch to switch to.
- `<file>`: The name of the file to restore. #### Switching Branches

```bash
# Switch to a branch
git checkout <branch>

# Switch to the previous branch
git checkout -
```

When cloning with `--depth=1`, you can switch to other branches—for example, switching to the `dev` branch—using the following steps:

```bash
git clone --depth=1 https://github.com/xjh22222228/git-manual.git

# Switch to the dev branch
git remote set-branches origin 'dev'
git fetch --depth=1 origin dev
git checkout dev
```

#### Creating Branches

```bash
# Create a local 'develop' branch and switch to it
git checkout -b develop

# Create a new branch based on a specific commit hash
git checkout -b new-branch commit-hash

# Create a remote branch (this actually creates a local branch first, then pushes it to the remote)
git checkout -b develop
git push origin develop

# Create an "orphan" branch (an empty branch that does not inherit from a parent branch and has an empty history); this typically requires at least 4 steps
git checkout --orphan develop
git rm -rf .  # Optional step: use this only if you truly want to create a branch with absolutely no files
git add -A && git commit -m "Initial commit" # Add and commit; otherwise, the branch will remain "hidden" (Note: Before executing this step, ensure that at least one file remains in your current working directory; otherwise, the commit will fail)
git push --set-upstream origin develop # Push the branch to the remote repository
```

#### Restoring a File to the State of the Last Commit

```bash
# The '--' separator followed by a filename indicates that the specified file should be restored to its state in the most recent commit
git checkout -- file.txt
```

## `git switch`: Switching and Creating Branches

`git switch` is a new command introduced in Git version 2.23. It is designed to simplify branch-switching operations and serves as a partial replacement for the functionality of `git checkout`. Its primary purpose is to facilitate switching between different branches, making these operations clearer and safer.

#### Basic Syntax

```bash
git switch [options] <branch>
git switch [options] -c <new-branch> [start-point]
```

- `options`: Optional parameters used to specify different operational behaviors.
- `<branch>`: The name of the target branch you wish to switch to.
- `-c`: Create a new branch and immediately switch to that branch. - `<new-branch>`: The name of the new branch to be created.
- `start-point`: An optional parameter specifying the starting commit for the new branch; by default, this is the latest commit on the current branch.

#### Switching Branches

```bash
# Switch to the 'develop' branch
git switch develop

# Switch to the previous branch
git switch -

# Force switch to the 'develop' branch, discarding all local changes
git switch -f develop

# -t: Switch to a remote-tracking branch. If you have added a new repository using 'git remote',
#     you will need to use the '-t' flag to switch to its branches.
git switch -t upstream/main
```

#### Creating Branches

```bash
# Create a new branch and switch to it
git switch -c newBranch

# Force-create a new branch (overwriting if it already exists)
git switch -C newBranch

# Create a new branch starting from the 3rd commit prior to HEAD
git switch -c newBranch HEAD~3

# You can also create a branch from a specific commit hash
git switch -c new-branch commit-hash

# --track: Create a 'dev' branch and set it to track the remote 'code/dev' branch
git switch --track code/dev
```

## `git cherry-pick`: Transferring Commits

`git cherry-pick` is a highly practical command in Git; its function is to apply specific commits from one branch onto the current branch.

#### Use Cases

- `Syncing Specific Commits`: When you only need to synchronize a subset of commits from one branch to another—rather than merging the entire branch—`git cherry-pick` comes in handy.
- `Fixing Specific Issues`: If a bug is discovered in a branch and has already been fixed in another, you can use `git cherry-pick` to apply the specific fix commit to the branch containing the bug.

#### Basic Usage

- `--edit|-e`: Allows you to edit the commit message before applying the commit.
- `--no-commit`: Applies the changes from the commit but does not automatically create a new commit; this allows you to manually commit the changes later.
- `--signoff`: Adds your signature to the commit message, indicating that you take responsibility for the commit. ```bash
# Single commit
git cherry-pick <commit-hash>

# Multiple consecutive commits
#  <start-commit-hash> is the hash of the starting commit, and <end-commit-hash> is the hash of the ending commit. Note that the starting commit itself is *not* included; only the commits from the one immediately following the start commit up to the end commit will be applied.
git cherry-pick <start-commit-hash>..<end-commit-hash>

# Multiple non-consecutive commits
git cherry-pick <commit-hash-1> <commit-hash-2> <commit-hash-3>
```

```bash
# Can be a commit ID or a branch name
# If it is a branch name, it refers to the latest commit on that branch
git cherry-pick <commit_id>|branch_name

# Supports transferring multiple commits; this will generate multiple commit records
git cherry-pick <commit_id1> <commit_id2>

# Preserve original author information when committing
git cherry-pick -x <commit_id>

# Edit the commit message; otherwise, the original commit message will be applied
git cherry-pick -e <commit_id>

# Abort the current operation and return to the initial state
git cherry-pick --abort

# If conflicts occur, resolve them, use `git add` to stage the changes, and then execute the following command to continue the process
git cherry-pick --continue
```

<details>
<summary>Demo: Transferring a commit (.gif) — Transferring the third commit from the `dev` branch to the current `main` branch.</summary>

<img src="media/cherry.gif">
</details>

## git stash: Temporarily Saving Changes

`git stash` is a practical command in Git that allows you to save uncommitted changes in your current working directory (including changes in both the staging area and the working tree). This restores the working directory to a clean state—matching the state of the last commit.

Use Case: Suppose you are halfway through implementing a feature on your current branch when you suddenly need to switch to another branch to fix a bug. However, you do not want to commit your unfinished work yet (since switching branches requires a clean working directory). This is exactly where `git stash` comes in handy. ```bash
# Save the current changes in the working directory
git stash

# Save changes with a descriptive message (recommended)
git stash save "Fixed Bug #28"

# Save changes, including untracked files
Files
git stash -u

# View the current list of stashes
git stash list

# Restore modified content to the working directory (this will remove the entry from the `git stash list`)
git stash pop # Restores the most recent stash to the working directory; by default, changes originally in the staging area are restored to the working directory.
git stash pop stash@{1} # Restores a specific stash ID (IDs can be found via `git stash list`).
git stash pop --index # Restores the most recent stash to the working directory, but restores content that was originally in the staging area back *into* the staging area.

# Identical to the `pop` command, with the sole difference being that it does *not* remove the entry from the stash list.
git stash apply

# Clear all stashes
git stash clear

# Clear a specific stash ID (if no ID is specified after `drop`, the most recent stash is cleared).
git stash drop stash@{0}
git stash drop # Clear the most recent stash

# View the content of the modified files within a saved stash
git stash show -p stash@{0}
```

## git status: File Status

`git status` is a fundamental and frequently used command in Git; it is used to display the current state of the working directory and the staging area. Through this command, you can see information such as which files have been modified, which files have been added to the staging area, which files have been deleted, and so on.

```bash
# View full file status details
git status

# Provide output in a short format
git status -s

# Ignore submodules
git status --ignore-submodules

# Show ignored files
git status --ignored
```

## git log: Commit History

Executing the `git log` command displays all commit records for the current branch, ordered from the most recent to the oldest. Each record includes the commit hash, author, date, and commit message. ```bash
# View the complete commit history
git log

# View the commit messages for the last N commits
git log -2

# View the last N commits, including diffs
git log -p -2

# Search through commit messages; use -i to ignore case
git log -i --grep="fix: #28"

# Search the working directory to find when the code snippet "alert(1)" was introduced
git log -S "alert(1)"

# View the commit history for a specific author
git log --author=xjh22222228

# View the commit history for a specific file
git log README.md

# Show only merge commits
git log --merges

# Display each commit on a single line, showing only the first few characters of the commit hash and the commit message, for quick review
git log --oneline

# View the log history as a graph
git log --graph --oneline

# View the history in reverse chronological order
git log --reverse

# --since and --until: Show commits within a specific date range
git log --since="2025-03-01" --until="2025-03-25"
```

#### Formatting Logs

When using the `git log` command, you can include the `--pretty=format` option to customize the log output format. **Common formats are as follows:**

| Parameter | Description                                                                    |
| ---- | ---------------------------------------------------------------------- |
| %H   | Full commit hash                                                       |
| %h   | Abbreviated commit hash (typically the first 7 characters)             |
| %T   | Full tree hash                                                         |
| %t   | Abbreviated tree hash                                                  |
| %an  | Author name                                                            |
| %ae  | Author email                                                           |
| %ad  | Author date, RFC2822 style: `Thu Jul 2 20:42:20 2020 +0800`                |
| %ar  | Author date, relative time: `2 days ago`                                       |
| %ai  | Author date, ISO 8601-like style: `2020-07-02 20:42:20 +0800`             |
| %aI  | Author date, ISO 8601 style: `2020-07-02T20:42:20+08:00`                  |
| %cn  | Committer name                                                         |
| %ce  | Committer email                                                        |
| %cd  | Committer date, RFC2822 style: `Thu Jul 2 20:42:20 2020 +0800`              |
| %cr  | Committer date, relative time: `2 days ago`                                     |
| %ci  | Committer date, ISO 8601-like style: `2020-07-02 20:42:20 +0800`           |
| %cI  | Committer date, ISO 8601 style: `2020-07-02T20:42:20+08:00`                |
| %d   | Reference names: (HEAD -> main, origin/main, origin/HEAD)                    |
| %D   | Reference names, without `()` or newlines: HEAD -> main, origin/main, origin/HEAD |
| %e   | Encoding                                                               |
| %B   | Raw commit body                                                        |
| %C   | Custom color                                                           |

Examples:

```bash
git log -n 1 --pretty=format:"%an" # xjh22222228

git log -n 1 --pretty=format:"%ae" # xjh22222228@gmail.com

git log -n 1 --pretty=format:"%d" #  (HEAD -> main, origin/main, origin/HEAD)

# Customize output color; the color name follows %C
git log --pretty=format:"%Cgreen Author: %an"
```

## `git shortlog`

The `git shortlog` command groups commits by author, counts the number of commits for each author, and displays the latest commit message for each one.

```bash
# Default output: grouped by contributor
git shortlog

# List contributors' code contributions; prints the author and contribution count
git shortlog -sn

# Sort by contribution count and print the commit messages
git shortlog -n

# View contributions formatted by email address
git shortlog -e
```

## `git reflog`

The `git reflog` command displays the history of updates to references in the local repository. Each entry includes the reference's hash, the operation performed, the commit message, the timestamp, and other details.

- Shows all movements of HEAD (or a specified reference) over time.
- Includes operations such as commits, branch switches, resets, and rebases—even if those commits no longer belong to any active branch.
- Focused on reference changes; it records the history of operations and is ideal for recovery and debugging purposes.

If you execute `git reset --hard` or delete a branch, certain commits may become "unreachable" and will no longer appear in `git log`.

```bash
# Output the log with each commit entry on a single line
git reflog

# Recover a lost commit by finding its commit_id using git reflog
git reflog
git reset --hard commit_id

# Specify the number of entries to display. For example, to display the 5 most recent entries:
git reflog -n 5

# Display entry dates using relative time (e.g., "2 days ago"):
git reflog --relative-date

# Display entry dates in a different format. For example, using the ISO format:
git reflog --date=iso
```

#### Notes

- The reflog records the operational history of your *local* repository; it is not pushed to the remote repository along with your code.
- Entries are retained by default for 90 days (for reachable objects) or 30 days (for unreachable objects); however, these durations can be adjusted via the configuration options `gc.reflogExpire` and `gc.reflogExpireUnreachable`.

## git blame: Last Modification Information

`git blame` is an extremely useful command in Git. Its primary function is to display the last modification information for each line of a file's content—including the commit hash, author, date, and commit message associated with the last change to that specific line.

#### Basic Syntax

```bash
git blame <filename>
```

```bash
# View modification details for the README.md file; this displays the modification info for every line.
git blame README.md

# View modification details for a specific range of lines within a file.
git blame -L 11,12 README.md
git blame -L 11 README.md   # View from line 11 onwards.

# Display the full commit hash (SHA-1).
git blame -l README.md

# Display the line numbers.
git blame -n README.md

# Display the author's email address.
git blame -e README.md

# Combine multiple arguments for a specific query.
git blame -enl -L 11 README.md

# -w: Ignore whitespace changes.
git blame -w README.md

# Display timestamps in a more readable format.
git blame -c README.md
```

## git merge: Merging Branches

`git merge` is the Git command used to integrate changes from one branch into the current branch.

Merging code from the `feature/v1.0.0` branch into the `develop` branch:

```bash
git checkout develop
git merge feature/v1.0.0
```
Merge the code from the previous branch into the current branch.

```bash
git merge -
```

Merge in quiet mode: merge the `develop` branch into the current branch without outputting any information.

```bash
git merge develop -q
```

Merge without editing the commit message; skip the interactive editor.

```bash
git merge develop --no-edit
```

Perform the merge but do not automatically create a commit afterward.

```bash
git merge develop --no-commit
```

Abort the merge and revert to the state prior to the merge attempt.

```bash
git merge --abort
```

Merge specific files or directories from another branch. Note that this directly overwrites existing files rather than performing a true semantic merge.

```bash
# Merge the two files src/utils/http.js and src/utils/load.js from the 'dev' branch into the current branch.
git checkout dev src/utils/http.js src/utils/load.js
```

Allow merging unrelated histories. If you cloned the repository using the `--depth` parameter, merging may result in significant conflicts; the `--allow-unrelated-histories` parameter effectively resolves this issue.

```bash
git merge develop --allow-unrelated-histories
```

Specify a custom commit message for the merge commit.

```bash
git merge develop -m "Merge develop branch into main"
```

## `git rm`: Deleting Files

`git rm <file>`: This command is used to remove a file from both the working directory and the index (staging area), and it records this removal operation for the next commit.

```bash
# Delete the file 1.txt.
git rm 1.txt

# Delete all files in the current directory; unlike the standard `rm -rf` command, this does *not* delete the .git directory.
git rm -rf .

# Clear the cache for the current working directory without deleting the actual files; typically used to resolve issues where filename changes are not being recognized.
git rm -r --cached .

# Remove a file from the index (staging area) while keeping the file in the working directory. This is useful when you want Git to stop tracking a specific file.
git rm --cached <file>
```

## `git restore`: Restoring Files

`git restore` is a command introduced in Git version 2.23. Its primary function is to restore the state of files in the working directory or the staging area.

It was introduced to separate the distinct responsibilities previously handled by `git checkout` and `git reset`. ```bash
# Discard changes to files in the working directory (excluding newly created files)
git restore README.md # A single file
git restore README.md README2.md # Multiple files
git restore . # All files in the current directory

# Move files from the staging area back to the working directory
git restore --staged README.md
```

## git pull: Fetch and Merge

`git pull` fetches the latest content and merges it into the current branch.

#### Fetching the Latest Content from a Remote Branch

By default, `git pull` fetches the current branch.

```bash
# Automatically merges if conflicts occur
git pull
```

#### Fetching a Specific Branch

```bash
# Remote_Branch_Name:Local_Branch_Name
git pull origin main:main
# If you are fetching a remote branch and merging it into the *current* local branch,
# you can omit the local branch name:
git pull origin main
```

#### Fetching into a Specific Working Directory

```bash
# By default, `git pull` operates within the current working directory;
# however, if you wish to pull into a specific directory, you can use the `-C` option.
git -C /opt/work pull
```

#### Syncing a Forked Repository

If you have forked someone else's repository and the original repository undergoes changes, you can merge those updates into your forked repository using the following steps:

```bash
# 1. Add the original remote repository: git remote add [Custom_Name] [Remote_Repo_URL]
git remote add upstream https://github.com/xjh22222228/git-manual.git

# 2. Fetch the latest content from the remote branch
git fetch --depth=1 upstream main

# 3. Merge the latest remote content into your current branch (allows merging unrelated histories)
git merge upstream/main --allow-unrelated-histories

# 4. Push the changes to your remote repository
git push
```

## git mv: Move/Rename Files

The `git mv` command is used to rename files or move them to a different location. While most developers choose to move files manually using their file system, there is a distinct difference between manual file movement and using `git mv`. The difference between performing this manually versus using the command (assuming `README.md` is renamed to `README2.md`):

- **Manual:** First delete `README.md`, then create `README2.md`; the commit history cannot properly track this change.
- **`git mv`:** This actually updates the index to rename the file, allowing for easy retrieval via the commit history.

The `git mv` command is very similar to the Unix `mv` command, if you are familiar with that.

**Note:** `git mv` does not support newly created files; they must be committed first.

```bash
# Rename 1.txt to 2.txt
git mv 1.txt 2.txt

# Forcefully rename 1.txt to 2.txt, regardless of whether 2.txt already exists
git mv -f 1.txt 2.txt

# Moving directories works the same way
git mv temp temp2
```

## `git diff`: Comparing File Content Differences

The `git diff` command is used to view the differences between the content of files in the **working directory** and those in the staging area or a remote repository.

#### `git diff`

```bash
# View differences between the working directory and the staging area for all files
git diff

# View differences between the working directory and the staging area for a specific file
git diff README.md

# View the content differences for a specific commit
git diff dce06bd

# Compare the differences between two specific commits
git diff e3848eb dce06bd

# Compare the latest commits of two branches (e.g., develop vs. main); returns nothing if there are no differences
git diff develop main

# Compare the differences in a specific file between two branches (e.g., README.md in develop vs. main)
git diff develop main README.md README.md

# View differences in files currently in a conflicted state within the working directory
git diff --name-only --diff-filter=U

# See which files were modified in the previous commit
git diff --name-only HEAD~
git diff --name-only HEAD~~ # ...or the commit before that (2 commits ago)
```

## `git show`: Viewing Historical Commit Information

You can use the `git show` command to view information regarding historical commits. ```bash
# If no arguments are specified, it defaults to showing the most recent commit details
git show

# Specify a commit_id to view details for that specific commit
git show d68a1ef

# You can also specify a commit_id and a filename to view the commit details for that specific file
git show d68a1ef README.md

# Specify only a filename to view the details of the most recent commit that included this file
git show README.md

# Specify a branch name to view the details of the latest commit on that branch
git show feature/dev
```

## `git reset`: Rolling Back Versions

There are two methods for rolling back versions:

- `git reset` — This alters the commit history. When `git reset` is used to move the HEAD pointer, any commits that are skipped (and have no other references pointing to them) may eventually be removed by Git's garbage collection mechanism, thereby disappearing from the commit history.
- `git revert` — This does not delete any existing commits; instead, it adds a *new* commit to the history that performs the inverse operation. The continuity of the commit history is preserved, and all original commits remain present in the historical record. `git reset` Command Usage:

```bash
# --hard: Discards changes in both the working directory and the staging area, reverting to the current commit.
git reset --hard

# Revert to the previous version.
git reset --hard HEAD^

# Revert to the version two commits ago.
git reset --hard HEAD^^

# Revert to a specific commit_id (viewable via `git log`).
git reset --hard 'commit id'

# Revert to the state before the last modification (default is --mixed: resets the staging area while keeping the working directory unchanged).
git reset HEAD~1

# --soft: Preserves the contents of both the staging area and the working directory.
git reset --soft HEAD^
```

`git revert` Command Usage:

```bash
# Revert the last commit.
git revert HEAD^

# Revert a specific commit.
git revert 8efef3d37

# --no-edit: Revert the commit and skip the commit message editing step.
git revert HEAD^ --no-edit

# Abort the current operation and restore the initial state.
git revert --abort

```

## `git tag` (Tags)

```bash
# List all local tags.
git tag

# List all remote tags.
git ls-remote --tags origin

# Search for tags matching a specific pattern (using `*` as a wildcard).
git tag -l "v1.0.0*"

# Create an annotated tag.
git tag -a v1.1.0 -m "Tag description"

# Create a lightweight tag (requires no additional arguments).
git tag v1.1.0

# Tag a past commit (if you forgot to tag it earlier; use `git log` to find the commit ID).
git log
git tag -a v1.1.0 <commit_id>

# Push a specific tag to the remote repository (tags are created locally by default).
git push origin v1.1.0

# Push all tags to the remote repository at once.
git push origin --tags

# Delete a local tag (you must run `git push origin v1.1.0` again to delete the corresponding remote tag).
git tag -d v1.1.0

# Delete a remote tag.
git push origin --delete v1.1.0

# Check out (switch to) a specific tag.
git checkout v1.1.0

# View detailed information for a specific local tag
git show v1.1.0
```

## git rebase

The `git rebase` command offers two particularly useful functions:

- Merging multiple commit records into a single one
- Serving as an alternative to `git merge` for integrating code

### 1. Merging multiple commit records into a single one

Note: Ensure that your current working directory is clean (contains no uncommitted changes) before proceeding with this operation.

1. Specify the range of commits you wish to manipulate; this will launch an interactive command interface.

```bash
# <start> is a required starting point; <end> is optional (defaults to the commit pointed to by the current branch's HEAD)
git rebase -i <start> <end>

git rebase -i HEAD~5 # Operate on the 5 most recent commits
git rebase -i e88835de # Alternatively, specify the target using a commit_id
```

| Parameter | Description                                                     |
| --------- | --------------------------------------------------------------- |
| p, pick   | Keep the current commit (this is the default action)            |
| r, reword | Keep the current commit, but edit its commit message            |
|
| e, edit   | Keep the current commit, but pause to make modifications.      |
| s, squash | Keep the current commit, but merge it into the previous commit. |
| b, break  | Pause here (use `git rebase --continue` later to resume the rebase). |
| d, drop   | Delete the current commit.                                     |

The commits are listed in reverse chronological order, with the most recent record appearing at the bottom.

<img src="media/gitrebase-3.png" width="700" />

2. Change every entry after the very first one to `s` or `squash`:

<img src="media/gitrebase-4.png" width="700" />

3. Press `:wq` to exit the interactive rebase session. You will then enter a second interactive session to edit the commit messages; if you do not need to modify the previous commit messages, simply exit this session immediately:

<img src="media/gitrebase-5.png" width="700" />

4. Force push to the remote repository:

```bash
# Push to the main branch
git push -u -f origin main
```

### 2. Merging Branch Code

It is often recommended to use `git rebase` instead of `git merge` for integrating changes. The key difference between the two is that `git rebase` results in a cleaner, more linear commit history. The following two images illustrate this comparison:

The first image depicts the result of `git rebase`, while the second shows the result of `git merge`.

As you can see, the history generated by `git rebase` forms a straight line, whereas `git merge` creates a complex web of intersecting lines that can be difficult to follow.

<img src="media/gitrebase-1.png" width="700" />
<img src="media/gitrebase-2.png" width="700" />

Let's assume we have two branches: `main` and `dev`. Below, we will use `git rebase` to merge the code from the `dev` branch into the `main` branch. ```bash
# 1. First, switch to the 'main' branch
git switch main

# 2. Rebase the 'dev' branch onto the current 'main' branch
git rebase dev

# If there are no conflicts, push directly
git push

# If conflicts occur: resolve conflicts => stage changes => continue => force push
git add -A
git rebase --continue # Continue the rebase
git push -f # Force push
```

Interrupting the `git rebase` operation: If you are halfway through the process and decide you no longer wish to use the `rebase` command, you can abort the current operation.

```bash
$ git rebase --abort
```

## Git Flow Workflow

Git Flow is a Git-based workflow model. It defines a strict branching structure centered around the release cycle of a project.

`git flow` merely simplifies the command-line operations; you do not strictly *need* to use the `git flow` tool itself. As long as you adhere to the Git Flow process—executing the commands manually one by one—the result is exactly the same.

Note that `git flow` is not a built-in Git command; it requires a separate installation.

#### Initialization

Every repository must be initialized once before Git Flow can be used. This initialization applies specifically to the current user.

```bash
# Typically, you can simply press Enter to accept the default settings
git flow init
```

#### Starting Development on a New Feature

Suppose we need to start developing a new feature—for instance, a login and registration system. At this stage, we would create a dedicated `feature` branch to carry out independent development.

```bash
# Step 1: Start a new feature. We'll name the branch 'v1.1.0'; once created, the full branch name will be 'feature/v1.1.0'.
git flow feature start v1.1.0

# Step 2: Publish the branch to the remote repository. This step is essential for team collaboration.
git flow feature publish v1.1.0

# Final Step: Finish the feature. This merges the current branch into the 'develop' branch, deletes the 'feature/v1.1.0' branch, and switches back to 'develop'.
git flow feature finish v1.1.0
```

#### Applying Hotfixes

When is a hotfix required? A hotfix is ​​necessary when a feature that has already been deployed to production contains a bug that needs to be fixed.

Hotfixes are specifically applied to the `main` branch. ```bash
# Step 1: Start a hotfix branch named 'fix_doc' to correct documentation errors; once created, the branch will be named 'hotfix/fix_doc'.
git flow hotfix start fix_doc

# Step 2: Push the branch to the remote repository. This step is optional; however, if multiple people are fixing bugs simultaneously, you should push the branch to share it.
git flow hotfix publish fix_doc

# Final Step: Finish the hotfix. This merges the current branch into both 'main' and 'develop', then deletes the branch and switches back to 'develop'.
git flow hotfix finish fix_doc
```

#### Releasing

Suppose the product team has provided a new requirement, and the work to fulfill it is complete; at this point, you may choose to perform a release. While releasing is not strictly mandatory, doing so creates distinct version markers, making it much easier to locate the code for a specific version in the future.

```bash
# Step 1: Create a new release version named 'v1.1.0'; once created, the branch will be named 'release/v1.1.0'.
git flow release start v1.1.0

# Step 2: Push the branch to the remote repository (optional).
git flow release publish v1.1.0

# Final Step: Finish the release. This merges the current branch into both 'main' and 'develop', applies a version tag, then deletes the current branch and switches back to the 'develop' branch.
git flow release finish v1.1.0
```

References:

- [https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [https://www.git-tower.com/learn/git/ebook/cn/command-line/advanced-topics/git-flow](https://www.git-tower.com/learn/git/ebook/cn/command-line/advanced-topics/git-flow)

#### Git flow schema

![](media/git-flow.png)

---

## git submodule

The purpose of `git submodule` is similar to that of a package manager (such as `npm`); it is primarily used for reusing repositories, though it is often more convenient to use than traditional package managers. Submodules do not necessarily require their own version branches for code management. Since a submodule depends on the main application, version branching operations can be performed directly from the main application's context. Consequently, once a new version branch is created within the main application, the current state of all submodules becomes "locked" to that specific branch—regardless of any subsequent modifications made within the individual submodule repositories.

#### Adding a Submodule

After adding a submodule, you will notice a new metadata file named `.gitmodules` appearing in the root directory; this file is primarily used for managing the submodules.

```bash
git submodule add https://github.com/xjh22222228/git-manual.git # Adds to the current directory by default
git submodule add https://github.com/xjh22222228/git-manual.git submodules/git-manual # Adds to a specified directory

# -b: Specifies a particular branch of the repository to be added
git submodule add -b develop https://github.com/xjh22222228/git-manual.git
```

#### Removing a Submodule

```bash
# 1. Directly delete the submodule directory
rm -rf submodule

# 2. Edit the .gitmodules file located in the root directory to remove the entry for the specific submodule you wish to delete.

# Finally, push the changes
git add -A
git commit -m "Remove submodule"
git push
```

#### Cloning a Repository Containing Submodules

```bash
# --recursive: Used for recursive cloning; otherwise, the submodule directories will remain empty.
git clone --recursive https://github.com/xjh22222228/git-manual.git

# If you have already cloned a project containing submodules but forgot to include the --recursive flag, you can use this command to initialize, fetch, and checkout any nested submodules.
git submodule update --init --recursive
```

#### Fixing Submodule Branches

After cloning a repository that contains submodules, you may discover that the submodules are not currently checked out to the correct branches. You can use the following command to rectify this:

```bash
git submodule foreach -q --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo main)'
```

#### Updating Submodule Code

Method 1: Typically, to update the code, one might simply execute `git pull`. However, this is considered a rather inefficient or "clumsy" approach. ```bash
# Recursively fetches all changes for submodules, but does not update the actual submodule content.
git pull

# At this point, you need to enter the submodule directory to perform the update. This completes the update for a single submodule; however, if you have many submodules, this process becomes quite tedious.
cd git-manual && git pull
```

Method 2: Update submodules using `git submodule update`

```bash
# Git will attempt to update all submodules. If you only need to update a specific submodule, simply specify the submodule's name after the --remote flag.
git submodule update --remote

# The --recursive flag recursively updates all submodules, including submodules nested within other submodules.
git submodule update --init --recursive
```

Method 3: Update using `git pull`. This is a newer update mode and requires Git version 2.14 or higher.

```bash
git pull --recurse-submodules
```

If you find it bothersome to manually add `--recurse-submodules` every time you run `git pull`, you can configure the default behavior of `git pull`. For instructions on how to configure this, please refer to the [Configuration](#Configuration) section.

For more detailed usage examples, please see: [Git Submodule Tutorial](https://www.xiejiahe.com/blog/detail/5dbceefc0bb52b1c88c30853)

## git subtree

If you are familiar with `git submodule`, you likely already have a rough idea of ​​what `git subtree` is used for; essentially, they serve the same purpose: reusing repositories or code.

The official recommendation is to use `git subtree` instead of `git submodule`.

Advantages of `git subtree`:

- Unlike submodules, it does not require a `.gitmodules` metadata file for management.
- The child repository is treated as a standard directory; in fact, from the perspective of the main repository, there is no distinct "repository" concept for the subtree.
- Supports older versions of Git (even versions older than v1.5.2).
- Managing simple workflows is very easy.

Disadvantages of `git subtree`:

- The commands can be overly complex, making operations like pushing and pulling quite cumbersome.
- Although intended as a replacement for submodules, its adoption rate is not as widespread as that of submodules.
- The child repository's contents are merged directly into the main repository, meaning their commit histories are effectively intertwined.
Records for Two Repositories

`git subtree` Command Usage:

```bash
git subtree add   --prefix=<prefix> <commit>
git subtree add   --prefix=<prefix> <repository> <ref>
git subtree pull  --prefix=<prefix> <repository> <ref>
git subtree push  --prefix=<prefix> <repository> <ref>
git subtree merge --prefix=<prefix> <commit>
git subtree split --prefix=<prefix> [OPTIONS] [<commit>]
```

When performing `git subtree` operations, your current working directory must be clean (empty of uncommitted changes); otherwise, the command cannot be executed.

#### Adding a Subtree

- `--prefix`: Specifies the location where the subtree will be stored.
- `main`: The branch name.
- `--squash`: The standard practice is *not* to store the entire history of the subtree within the main repository; if you wish to include the full history, you can simply omit this entire parameter.

Once a subtree is added, it is treated just like any ordinary file or directory. If you navigate into the `sub/common` directory and run `git remote -v`, you will find that no remote repository is listed there.

```bash
git subtree add --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash
```

#### Updating a Subtree

When there are content changes in the remote subtree repository, you can update your local copy using the following command:

```bash
git subtree pull --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash
```

#### Pushing to a Subtree

If you have modified content within the subtree directory, you can push those specific changes back to the remote subtree repository.

```bash
# First, you need to stage the subtree code changes within the main repository.
git add sub/common
git commit -m "Subtree modifications"
# Then, push the changes.
git subtree push --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash
```

#### Splitting

As a project undergoes iteration, the main repository accumulates a large number of commits. Consequently, you may notice that every `push` operation becomes very slow—a performance issue that is particularly noticeable on the Windows platform.

Each time you `push` changes to the subtree repository, a significant amount of time is consumed by the process of recalculating the commits specific to that subtree. Furthermore, because every `push` operation involves a fresh re-calculation, the commits in the local repository and the remote repository will invariably differ; this prevents Git from resolving potential conflicts.

When you use the `git split` command followed by `git subtree push`, Git calculates only the new commits generated by the split operation.

```bash
git subtree split --prefix=sub/common --branch=main
```

#### Streamlining Commands

Based on the practical steps above, it is easy to see that `git subtree` is quite verbose; having to type such a long command for every operation is simply unbearable.

You can add the sub-repository as a remote repository:

```bash
# 'common' is the repository name; you can define it however you like.
git remote add -f common https://github.com/xjh22222228/git-manual.git
```

Once this is set up, you no longer need to type out the full repository URL when executing other `git subtree` commands:

```bash
git subtree push --prefix=sub/common common main --squash
```

Although we have eliminated the repository URL, the command remains quite lengthy.

There is another solution: using aliases. For instance, on macOS or Linux systems, you can use the [`alias`](https://github.com/xjh22222228/linux-manual#alias) command:

```bash
alias push="git subtree push --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash"
```

Alternatively, you can utilize Git's own built-in alias feature => [Command Alias ​​Configuration](#Command-Alias-Configuration)

If you are a front-end developer, you can add the following entry to your `package.json` file:

```json
{
"scripts": {
"push": "git subtree push --prefix=sub/common https://github.com/xjh22222228/git-manual.git main --squash"
}
}
```

The next time you need to push, simply execute:

```bash
npm run push  or  yarn push
```

## git bisect: Binary Search

`git bisect` is based on the binary search algorithm and is used to pinpoint the specific commit that introduced a bug. It primarily involves four commands. This command is extremely useful; if you are unsure which specific commit introduced a bug, you can try this method.

```bash
# Start the bisect session
git bisect start [end_point] [start_point] # Use `git log` to identify the start and end points
git bisect start HEAD 4d83cf

# Mark the current commit as "good" (bug-free)
git bisect good

# Mark the current commit as "bad" (containing the bug)
git bisect bad

# Exit the bisect session
git bisect reset
```

Reference: [https://github.com/bradleyboy/bisectercise](https://github.com/bradleyboy/bisectercise)

## `git archive`: Creating Archives

This command creates an archive file; you can think of it as compressing the current project into a single file. It automatically ignores the `.git` directory.

However, unlike standard compression tools such as `zip` or `tar`, `git archive` allows you to create an archive specifically from a particular branch or commit.

**Parameters**

| Parameter  | Description                                                                                             |
| ---------- | ------------------------------------------------------------------------------------------------------- |
| `--format` | Optional: Specifies the output format. Defaults to `tar`; supports `tar` and `zip`. If omitted, the format is inferred from the file extension specified in `--output`. |
| `--output` | Specifies the destination path for the output file.                                                       |

```bash
# Archive the 'main' branch and package it as 'output.tar.gz' in the current directory
git archive --output "./output.tar.gz" main

# Archive a specific commit
git archive --output "./output.tar.gz" d485a8ba9d2bcb5

# Archive as a .zip file; no need to specify --format, as it is inferred from the file extension
git archive --output "./output.zip" main

# Archive one or more specific directories, rather than the entire project
git archive --output "./output.zip" main src tests
```

## Clearing Commit History

There are two methods for clearing the commit history. 1. The principle behind the first method involves creating a new branch. Let's assume the branch you wish to clear of commits is `develop`.

```bash
# 1. Create a new branch
git checkout --orphan new_branch
# 2. Stage all files and commit them
git add -A && git commit -m "First commit"
# 3. Delete the local 'develop' branch
git branch -D develop
# 4. Rename the 'new_branch' to 'develop'
git branch -m develop
# 5. Force-push the 'develop' branch to the remote repository
git push -f origin develop
```

2. The second method involves updating the branch `reference`. Let's assume you want to reset the `main` branch.

```bash
# Use 'git log' to find the ID of the very first commit
git update-ref refs/heads/main 9c3a31e68aa63641c7377f549edc01095a44c079

# You can then proceed to commit
git add .
git commit -m "First commit"
git push -f # Note: You must force-push
```

## Help

```bash
# Print detailed information for all Git commands
git help

# Print a list of all Git commands (without detailed descriptions; this view is cleaner)
git help -a

# List all configurable variables
git help -c
```

## Commit Conventions

| Tag      | Description                          |
| -------- | ------------------------------------ |
| feat     | The commit introduces a new feature    |
| style    | Typically involves code formatting changes |
| chore    | Changes to the build process or auxiliary tools |
| fix      | Bug fixes                            |
| docs     | Documentation updates                |
| test     | Unit test updates                    |
| refactor | Code refactoring                     |
| perf     | Performance optimizations or user experience improvements |
| revert   | Reverting to a previous version      |
| merge    | Code merging                         |
| typo     | Typos (e.g., misspelled words)   ​​    |

**Examples:**

```bash
# Introducing a new feature
git commit -m "feat: Add XX feature"

# Code formatting
git commit -m "style: Standardize ESLint"

# Modify Jenkins build process
git commit -m "chore: Update Jenkins"

# Fix a bug (it is recommended to provide a clear description for easy lookup later; #688 refers to the specific issue ID)
git commit -m "fix(Login flickering): #688"

# Update documentation
git commit -m "docs: git pull"

# Unit test changes
git commit -m "test: Test login"

# Refactor project code
git commit -m "refactor: Refactor workflow module"
```

## Resolving Conflicts

**Code merging/updating** frequently leads to conflicts.

#### The process for resolving conflicts is as follows:

1. Run `git pull` to fetch the latest code; Git will automatically attempt to merge it.
2. Edit the conflicted files, deciding whether to keep the local code or the remote code based on the specific situation.
3. Stage the files and push them to the remote repository.

<details>
<summary>Click
<details>
<summary>Click to view: Resolving Conflicts (.gif)</summary>

<img src="media/git-merge-conflict.gif">
</details>

For GUI-oriented users, three tools are recommended specifically for handling Git conflicts:

- [meld](http://meld.sourceforge.net/install.html)
- [kdiff3](http://kdiff3.sourceforge.net/)
- Executing the `git mergetool` command during a conflict will launch a default GUI tool.

[This article provides a dedicated guide on how to use these two tools.](https://gitguys.com/topics/merging-with-a-gui/)

## Repository Migration

Repository migration can also be referred to as repository cloning.

Sometimes it becomes necessary to migrate from an old repository to a new one. While manual file copying allows you to transfer the files themselves, if you need to transfer branches, tags, and commit history along with them, you must perform a full repository clone.

Old Repository A: https://github.com/xjh22222228/A.git
New Repository B: https://github.com/xjh22222228/B.git

1. Clone the old repository as a "bare" repository.

```bash
# Clone a bare repository; it contains no working directory content.
git clone --bare https://github.com/xjh22222228/A.git
```

2. Mirror-push to the new repository.

```bash
cd A
git push --mirror https://github.com/xjh22222228/B.git
```

3. Delete the old repository directory you just cloned.

```bash
rm -rf A
```

4. Clone the new repository.

```bash
git clone https://github.com/xjh22222228/B.git
```

In addition to migrating via command-line tools, you can also migrate a repository by using the web-based import feature provided by the hosting platform. ## Tips & Tricks

**Beautifying `git log` — Rivaling GUI Clients**

```bash
# 1. Global Configuration
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# 2. Run the command below to make your logs highly visual and intuitive
git lg

# Here are a few alternative modes; choose the one you prefer to set up your alias
git config --global alias.lg "log --graph --pretty=format:'%Cred%h - %Cgreen[%an]%Creset -%C(yellow)%d%Creset %s %C(yellow)<%cr>%Creset' --abbrev-commit --date=relative"

git config --global alias.his "log --graph --decorate --oneline --pretty=format:'%Creset %s %C(magenta)in %Cred%h %C(magenta)commited by %Cgreen%cn %C(magenta)on %C(yellow) %cd %C(magenta)from %Creset %C(yellow)%d' --abbrev-commit --date=format:'%Y-%m-%d %H:%M:%S'"

git config --global alias.hist "log --graph --decorate --oneline --pretty=format:'%Cred%h - %C(bold white) %s %Creset %C(yellow)%d  %C(cyan) <%cd> %Creset %Cgreen(%cn)' --abbrev-commit --date=format:'%Y-%m-%d %H:%M:%S'"
```

<details>
<summary>Preview Image (.png)</summary>

<img src="media/git-log.png">
</details>

## GUI Clients

Here are a few recommended Git GUI tools that are particularly useful, listed in no particular order. - Free - [GitHub Desktop](https://desktop.github.com/)
- Free - [Sourcetree](https://www.sourcetreeapp.com/)
- Free - [TortoiseGit](https://tortoisegit.org/)
- Free - [GitKraken](https://www.gitkraken.com/)
- Free - [GitUp](https://gitup.co/)
- Free - [Magit](https://github.com/magit/magit)
- Paid - [SmartGit](https://www.syntevo.com/smartgit/)
- Paid - [Git-Fork](https://git-fork.com/)
- Paid - [Tower](https://www.git-tower.com/)
- Paid - [LazyGit](https://github.com/jesseduffield/lazygit)

## Cloning Repositories via SSH

Cloning a repository using SSH requires generating a pair of SSH public and private keys on your computer first. The steps for generating these keys are as follows:

1. Navigate to the SSH directory:

```bash
cd ~/.ssh
```

2. Replace the placeholder with your GitHub email address:

```bash
# -t ed25519: Use the Ed25519 algorithm (more modern and secure).
# -C: Add a comment—typically your email address; this does not necessarily have to match your GitHub email.
ssh-keygen -t ed25519 -C "your_email@example.com"

# Follow the prompts; you can simply press Enter to accept the defaults. By default, the keys will be generated as ~/.ssh/id_ed25519, though you may change the filename for organizational purposes.
```

3. View your public key and add it to your GitHub account:

[https://github.com/settings/keys](https://github.com/settings/keys)

```bash
# The output will look something like: ssh-ed25519 AAAAC3Nza... your_email@example.com. Copy the entire content.
``` cat ~/.ssh/id_ed25519.pub
```

4. Add the SSH Key

```bash
ssh-add ~/.ssh/id_ed25519
```

5. Test the Connection

```bash
# If the following message is displayed, the SSH connection was successful:
# Hi xxxxx! You've successfully authenticated, but GitHub does not provide shell access.
ssh -T git@github.com
```

#### Managing Multiple GitHub Accounts

If you have multiple GitHub accounts, you will need additional `ssh config` configuration.

Edit `~/.ssh/config`:

```bash
vim ~/.ssh/config
```

```bash
# 'Host' is a custom name; it is typically named after the GitHub account.
# Account 1
Host user1
HostName github.com
User git
# Update this to your specific key file path
IdentityFile ~/.ssh/id_ed25519

# Account 2
Host user2
HostName github.com
User git
IdentityFile ~/.ssh/id_ed25519_2
```

Test the connection using the custom name:

```bash
ssh -T git@user1
```

Clone a Repository

```bash
#             Host:User/Repository
git clone git@user1:admin/demo.git
```

## Other

```bash
# Check Git version
git --version

# Clear local Git cache
git rm -r --cached .

# List files that are not ignored by .gitignore
git ls-files
```

## Remembering Passwords

Using the HTTPS method requires you to enter your username and password every time. If you want to avoid being prompted for credentials in the future, you can use the following methods:

```bash
# Temporarily remember password (default: 15 minutes)
git config --global credential.helper cache

# Customize password cache duration (in seconds)
git config credential.helper 'cache --timeout=3600'

# Remember password long-term
git config --global credential.helper store
```

## Clearing Credentials

Clear saved Git usernames and passwords:

```bash
# Windows
git credential-manager uninstall

# Mac / Linux (Either of the following commands will work)
git config --global credential.helper ""
git config ```bash
--global --unset credential.helper
```

## Speed ​​Boost

Cloning or downloading repositories from within China can be quite slow; you can utilize the mirror sites listed below to accelerate the process.
Cloning:

```bash
# Public Repository
git clone https://ghproxy.com/https://github.com/xjh22222228/git-manual.git

# Private Repository (Requires a Personal Access Token) => https://github.com/settings/tokens
git clone https://user:your_token@ghproxy.com/https://github.com/your_name/your_private_repo
```

Resource Acceleration:

```bash
https://raw.githubusercontent.com/xjh22222228/git-manual/main/media/poster.png
# ↓ Replace with
https://cdn.jsdelivr.net/gh/xjh22222228/git-manual@main/media/poster.png

# Alternative Domains (Simply replace the domain name)
# testingcf.jsdelivr.net
# img.jsdmirror.com
# gcore.jsdelivr.net
```

###### GitHub Files / Gists / Raw Content Acceleration:

To use this feature, visit [https://www.7ed.net/](https://www.7ed.net/)

## Mind Map

![](media/map.jpg)

[⬆ Back to Top](#)
