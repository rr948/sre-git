# Git

- [Git](#git)
  - [Git in a nutshell](#git-in-a-nutshell)
  - [Git introduction](#git-introduction)
  - [Getting started with repositories](#getting-started-with-repositories)
    - [Create a repository](#create-a-repository)
    - [Clone an existing remote repository](#clone-an-existing-remote-repository)
    - [Fork a repository](#fork-a-repository)
    - [Duplicate a repository](#duplicate-a-repository)
  - [Git high level commands](#git-high-level-commands)
    - [Setup & configuration](#setup--configuration)
    - [Getting & creating projects](#getting--creating-projects)
    - [Basic snapshotting](#basic-snapshotting)
    - [Clean-up](#clean-up)
    - [Stashing](#stashing)
    - [Tagging](#tagging)
    - [Patching](#patching)
    - [Undoing & resetting](#undoing--resetting)
    - [Sharing & updating projects](#sharing--updating-projects)
    - [Branching & merging](#branching--merging)
    - [Inspection](#inspection)
    - [Comparison](#comparison)
    - [Logging](#logging)
  - [Git low level commands](#git-low-level-commands)
  - [Exploring history](#exploring-history)
  - [Clean-up Git mess](#clean-up-git-mess)
  - [Examples](#examples)
    - [Making changes](#making-changes)
    - [Switching branches](#switching-branches)
    - [Collaborating with others](#collaborating-with-others)
  - [Git terminology](#git-terminology)
  - [References](#references)

## Git in a nutshell

- Distributed version control system for versioning files and folders
- Fast, free, and open source
- Efficient collaboration tool for any kind of project
- Simultaneous working on projects by using multiple local branches
- Simple and easy backup of the main server
- Integrated review process

**The basic ideas of Git:**

- The object database is the rather elegant system used to store the history of project-​files, directories, and commits.

- The index file is a cache of the state of a directory tree, used to create commits, check out working directories, and hold the various trees involved in a merge.

## Git introduction

Git is a fast, scalable, free, and open source distributed **version control system** designed to handle everything from small to very large projects with speed and efficiency.

Git offers an unusually rich command set that provides both high-level operations and full access to internals.

It outclasses SCM tools like Subversion, CVS, Perforce, and ClearCase with features like cheap local branching, convenient staging areas, and multiple workflows.

Git allows to have multiple local branches that can be entirely independent of each other. Notably, not all branches have to be pushed when pushing to a remote repository.

Git is distributed, which means that the entire repository is cloned ensuring a full backup of the main server.

Unlike the other systems, Git has something called the **_staging area_** or **_index_**. This is an intermediate area where commits can be formatted and reviewed before completing the commit. Git also makes it easy to ignore this feature. If a `-a` flag is added to the commit command, all changes to all files are added to the staging area.

Git commands are divided into **high level ("porcelain") commands** and **low level ("plumbing") commands**.

## Getting started with repositories

### Create a repository

```sh
git init
git add README.md # can be skipped
git commit -m "Initial commit" # can be skipped
git remote add origin [url]
git push -u origin master # push on remote master branch
```

### Clone an existing remote repository

```sh
git clone [SSH_url]
```

### Fork a repository

[GitHub Docs: How to fork a repository](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo)

### Duplicate a repository

1. Open Git Bash.
2. Create a bare clone of the repository.

```sh
git clone --bare https://github.com/exampleuser/old-repository.git
```

3. Mirror-push to the new repository.

```sh
cd old-repository.git
git push --mirror https://github.com/exampleuser/new-repository.git
```

4. Remove the temporary local repository you created earlier.

```sh
cd ..
rm -rf old-repository.git
```

## Git high level commands

### Setup & configuration

- `git [command] -h` — display options for the specified command
- `git config` — query / set / replace / unset global and repository options
- `git config --global color.ui auto` — enables helpful colorization of command line output
- `git config --global user.name "[user_name]"` — globally sets the name attached to commit transactions
- `git config --global user.email "[user_email@example.com]"` — sets the email attached to commit transactions
- `git config --list` — show all config settings
- `git config user.name` — show the username
- `git config user.email` — shows the email
- `git config rerere.enabled true (--global)` — turn on Git Reuse Recorded Resolution (globally for all projects)
- `git help` — display help information about Git
- `git rerere diff` — show merge conflicts

### Getting & creating projects

- `git clone` — clone a repository into a new directory, including all of the files, branches, and commits
- `git clone [directory] [new_directory]` — clone the directory named [directory] inside the current working directory into a new directory named [new_directory] inside the current working directory
- `git clone [url] [new_directory]` — clone directory with the link [url] into a new directory named [new_directory]
- `git init` — create an empty Git local repository or reinitialize an existing one
- `git mv [file] [new_folder]"` — move file named [file] to a new folder [new_folder]
- `git remote` — manage the set of repositories ("remotes") whose branches are tracked
- `git remote -v` — view remote conditions (upstream and downstream link)
- `git remote add origin [url]` — add a remote connection between the local repository and the remote with the link [url]
- `git remote add upstream [url]` — add a remote connection to the forked remote upstream (repo) with the link [url]
- `git remote set-url` — add a remote repository (i.e. connect local repo to Github)
- `git worktree list` — lists all existing working trees (a repository can have multiple working trees)

### Basic snapshotting

- `git add .` — add all changes in the current directory to all files in the _staging area_
- `git add -u` — update all tracked files in the entire working tree (e.g. added and deleted ones)
- `git add -a` / `git add --all` — add all changes to all files in the _staging area_
- `git add [file1] [file2]` — add contents of [file1] and [file2] to the _index_ / _staging area_
- `git add --update` / `git add -u` — update the index just where it already has an entry matching [pathspec]; if no [pathspec] is given, all tracked files in the entire working tree are updated
- `git add --verbose` / `git add -v` — be verbose when adding all changes to the _staging area_
- `git commit` — record and add changes to the repository
- `git commit -a` — automatically stage and record all files that have been modified and deleted, but new files unknown to Git are not affected
- `git commit -m "[message]"` — instantly add a commit message to the commit
- `git commit -a -m "[message]` — stage changes and add a commit message
- `git commit -v` — show unified diff between the HEAD commit and what would be committed at the bottom of the commit message template to help the user describe the commit
- `git notes` — add, remove, or read notes attached to objects, without touching the objects themselves
- `git status` — show the working tree status

> **Note:** Do not fix generated files such as package-lock.json. Re-generate these files.

### Clean-up

- `git clean` — clear working area by deleting untracked files
- `git clean --dry-run` — check cleanup affected files before deletion
- `git clean -f` / `git clean --force` — remove untracked files from the working tree
- `git clean -d` — clean both files and directories

### Stashing

- `git checkout [stash_name] -- [file]` — grab a single file from a stash
- `git stash` — save temporarily
- `git stash --include-untracked` / `git stash -u` — keep untracked (working area) files
- `git stash --all` / `git stash -a` — keep all files, even ignored ones
- `git stash apply` — apply the last stash
- `git stash apply stash@{0}` — apply the recently created stash
- `git stash apply stash@{n}` — apply the specified n-th stash
- `git stash branch [optional_stash_name]` / `git stash branch [branch_name] stash@{n}` — start a new branch from a stash
- `git stash clear` — remove all stashes
- `git stash drop` — remove the last stash
- `git stash drop stash@{n}` — remove the n-th stash
- `git stash list` — list all stashed changes
- `git stash pop` — remove the last stash and applying changes (impossible if there's a merge conflict)
- `git stash pop stash@{n}` — remove the specified stash n
- `git stash push` — save local modifications to a new stash entry
- `git stash save "WIP: [foo bar buzz]"` — name stashes for easy reference
- `git stash show stash@{n}` — show the contents (detailed information) of a specific stash (reference)
- `git stash show -p stash@{n}` — show the diff between the specified stash and the respective commit

### Tagging

- `git show [tag]` — look at the tag or tagged contents
- `git show-ref --tags` — list all tags and what commit they are pointing to
- `git tag [tag]` — add the specified tag
- `git tag` — list all tags in a repo
- `git tag -a [tag] -m "[message]"` — add annotated tag with a message
- `git tag --points-at [commit]` — list all the tags pointing ot a commit

### Patching

- `git add --patch` / `git add -p` — stage commits in hunks (partial staging) -> type `?` and press enter after `Stage this hunk` to show shortcut keys explanations
- `git am` — split mail messages in a mailbox into commit log message, authorship information and patches, and applies them to the current branch
- `git am --abort` — restore the original branch and abort the patching operation
- `git am --continue` — make a commit using the authorship and commit log extracted from the e-mail message and the current index file, and continue after a patch failure
- `git am --skip` — skip the current patch when restarting an aborted patch
- `git am --show-current-patch` — show the message at which git am has stopped due to conflicts
- `git apply` — apply a patch to files and/or to the index
- `git stash --patch` / `git stash -p` — add to stash in hunks (git will intelligently break up the changes into hunks)
-

### Undoing & resetting

- `git checkout -- [file]` — replace working area copy with the version from staging area (files are overwritten without warning!) -> discard changes made to the file in the working area
- `git checkout [commit] -- [file]` — update the staging area to match the commit and update the working area to match the staging area (files are overwritten without warning!)
- `git checkout [deleting_commit]^ -- [file]` — restore a deleted file
- `git commit --amend` — manipulate previous commit to add files or change commit message, the message from the original commit is used as the starting point, instead of an empty message, when no other message is specified from the command line via options such as `-m`
- `git commit --amend --no-edit` — manipulate previous commit without changing commit message
- `git commit --fixup [commit]` — create new commit to amend the specified commit (message starts with "fixup")
- `git mv [file]` — rename a file in the next commit
- `git rebase -i [commit_to_fix]^` — interactive rebase
- `git rebase -i --autosquash [commit]^` — squash fixup commit with the parent of the specified commit
- `git rebase -i --exec "run-tests" [commit]` — execute specified command after commit when interactive rebasing
- `git rebase --abort` — undo rebase and reset HEAD to the original branch
- `git rebase --continue` — continue rebase 
- `git rebase master` — rewind HEAD back to master and add new commits (copy) on top aka give a commit a new base commit (parent)
- `git reset` — reset current HEAD to the specified state (unstage files)
- `git reset ORIG_HEAD` — undo a `git reset`
- `git reset -- [file]` — copy file from commit to staging area without moving the HEAD pointer
- `git reset [branch] --hard` — reset back to specified branch
- `git reset HEAD [file]` — unstage file added to the working directory
- `git reset [commit] -- [file]` — copy file from the specified commit to the staging area without moving the HEAD pointer (reset the staging area), does not work with flags (hard, soft, mixed)
- `git reset [commit]` — undo all commits after the specified commit, preserving changes locally
- `git reset --hard [commit]` — discard all history and changes back to the specified commit
- `git reset --soft HEAD(~)` — move HEAD pointer to previous commit
- `git reset --mixed HEAD` — (default) move the HEAD pointer to previous commit and copy the file from the commit, that it is pointing to, to the staging area
- `git reset --hard HEAD` — move HEAD pointer to previous commit, copy the file from the commit to the staging area and to the working area
- `git reset --hard` — reset the index and working tree (changes to tracked files in the working tree since commit are discarded)
- `git reset --merge ORIG_HEAD` — undo a merge while preserving any uncommitted changes with the `--merge` flag
- `git restore` — restore specified paths in the working tree with some contents from a restore source
- `git revert [commit]` — reverts the specified commit, reverting the changes that the related patch introduced, and records a new commit indicating the reversion (the original commit stays in the repo)
- `git rm [file]` — remove file named [file] from the working tree and index

  > **NOTE:** `--` signifies the end of a command operation and the start of positional parameters.

### Sharing & updating projects

- `git cherry -v` — show commits, which have not been pushed upstream yet
- `git cherry-pick` — apply changes introduced by one or more existing commits recording a new commit for each
- `git fetch` — download objects and refs from a remote repository to keep local repo up-to-date with remote (no changes to local repo)
- `git pull` — fetch from a remote repository and integrate (merge) with the current local branch of the working directory / shorthand for `git fetch` && `git merge`
- `git pull [remote_name] [branch_name]` — fetch from a remote repository and integrate with another repository or a local branch / shorthand for `git fetch` && `git merge FETCH_HEAD`, e.g. `git pull origin feature_1`
- `git pull --rebase` — fetch, update local branch to copy upstream branch, and replay any commits made via rebase (no extra merge commit)
- `git push` — update remote refs along with associated objects
- `git push -u origin master` — upstream, initial update, e.g. push changes of the remote "origin" to the branch named "master" / shorthand for `git push --set-upstream origin master`
- `git push [remote_name] [branch_name]` — push changes to the specified remote, e.g. `git push origin feature`
- `git push --tags` — push all local tags to remote repo
- `git push [tag]` — push specified local tag to remote repo
- `git submodule` — initialize, update, or inspect submodules

> **NOTE:** Tags are not automatically pushed to the remote repo.

### Branching & merging

- `git branch` — show existing branches
- `git branch -r`— show all remote branches
- `git branch -a` — show branches in both local and remote repo
- `git branch -v` — show the last commit on each branch
- `git branch -vv` — show which remote / upstream branch is being tracked on local branch and check status
- `git branch -d [branch_name]` — delete the branch [branch_name]
- `git branch -D [branch_name]` — delete the specified branch irrespective of its merged status (`-D` is a shortcut for `--delete --force`)
- `git branch -m [new_branch_name]` — rename current branch
- `git branch --merged master` — shows all branches that have been merged with the master and can be cleaned up
- `git branch --no-merged master` — show all branches that have not been merged yet with the master
- `git checkout -b [branch_name]` — create and switch to the new branch named [branch_name] in one line
- `git checkout -t origin/[branch]` — checkout a remote branch, with tracking
- `git checkout [branch_name]` — move onto the specified branch
- `git checkout -b [local_branch] origin/[remote_branch]` — Branch [local_branch] set up to track remote branch [remote_branch] from origin e.g. `git checkout -b serverfix origin/serverfix`
- `git merge` — combines the specified branch’s history into the current branch
- `git merge [branch] --no-ff` — merge while retaining the history (no fast-forward)
- `git show-branch` — show local branches and associated commits
- `git show-branch -r` — show remote branches and associated commits
- `git show-branch -a` — show all branches and associated commits
- `git switch branch [branch_name]` — switch to the specified branch

See also:

- [3.5 Git Branching - Remote Branches](https://git-scm.com/book/id/v2/Git-Branching-Remote-Branches)
- [Git merge conflicts](https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts)

### Inspection

- `gitk` — show graphical representation of the resulting history
- `git show` — shows one or more objects (blobs, trees, tags, and commits), e.g. commits are displayed with log message, textual diff, and merge commit
- `git show [commit]` — outputs metadata and content changes of the specified commit
- `git show [commit] --stat` — show files changed in commit
- `git show [commit]:[file]` — look at a file from another commit

### Comparison

- `git diff` — show unstaged changes between commits, between a commit and working tree, between the working tree and the index or a tree, between two trees, changes resulting from a merge, etc.
- `git diff --staged`— show staged changes, which will be part of the next commit (`--staged` is a synonym for `--cached`)
- `git diff [first_branch]...[second_branch]` — shows content differences between two branches
- `git range-diff` — show the differences between two versions of a patch series, or more generally, two commit ranges (e.g. two versions of a branch)

### Logging

- `git log` — show commit logs and displays history of changes of the current branch; exit with `q` or **add `--no-pager`** to open the log in the CLI
- `git log --follow [file]` — lists version history for a file, including renames
- `git log --oneline --graph --decorate --all` — show all commit logs with commit number and message in one line
- `git log --graph` — show commit logs with commit number, message, and author as a graph
- `git log --since="yesterday"` — show commit logs since yesterday
- `git log --since=2.weeks` — show commit logs from the last two weeks
- `git log --grep=author --author=name --since=2.weeks` — search for commit messages, which match a regex
- `git log --name-status --follow (--) [file]` — track files that have been renamed / changed
- `git log --diff-filter=R -- [find-renamed]` — find only files that have been renamed
- `git log --diff-filter=M` — filter and show only files that have been modified
- `git log --diff-filter=A` — filter and show only files that have been added
- `git log --diff-filter=D` — filter and show only files that have been deleted
- `git log --diff-filter=D -- [file]` — filter commit of specified file that has been deleted
- `git log -p` — display complete diffs at each step
- `git log [commit]` — show history details of the specified commit
- `git shortlog` — summarize `git log` output in a format suitable for inclusion in release announcements with each commit will grouped by author and title.

## Git low level commands

- `git cat-file -t [SHA1 hash]` — print the type of the object inside the `.git/objects` directory
- `git cat-file -p [SHA1 hash]` — print the content of the object inside the `.git/objects` directory
- `cat HEAD` — check out the HEAD pointer (e.g. master reference: `ref: refs/heads/master`) inside the `.git` directory
- `cat heads/master` — check out the master reference and the commit pointed to (the last commit) inside the `.git/refs` directory
- `git ls-files -s` — print out the content (files) with the mode, the SHA matching that in the repo, and the file name
- `git branch [new_branch] [commit]` — detached HEAD: create new branch pointing to the last commit and save changes
- `git show-ref --heads` — list all heads and what commit they are pointing to

## Exploring history

[History commands](https://git-scm.com/docs/gittutorial)

## Clean-up Git mess

![Git mess](./demo-5baf1bab.png 'Clean-up Git mess')

## Examples

### Making changes

How to commit and push changes including log messages to the GitHub repository using the command line

1. `cd [repository]` — access the Git repository / working directory
2. `git add [file1] [file2]` — add files modified to temporary staging area called _index_ or _staging area_ to be formatted or reviewed OR `git add -a` — add all changes to all files in the _staging area_
3. `git commit` — record files to repository OR `git commit -m" [commit_message]"` to avoid launching the editor Vim
4. If Vim pops up, enter commit message (with title and description)
5. `git push` — update remote refs along with associated objects

### Switching branches

How to create new branches and switch between existing ones in order to add content

1. `git branch` — show existing branches
2. `git branch [new_branch_name]` — create a new branch named [new_branch_name]
3. `git branch` — show existing branches including the new branch
4. `git switch branch [new_branch_name]` — switch to the new branch
5. `git commit -a` — add file to the _staging area_ of the new branch
6. `git switch branch master` — switch to the master branch
7. `git merge [new_branch_name]` — merge the changes in the new branch into the master
8. `gitk` — show graphical representation of the resulting history
9. `git branch -d [new_branch_name]` — delete the specified branch

### Collaborating with others

How to clone a repository in order to collaborate with others and make, fetch, and pull changes

1. First person: `git clone [original_repository] [clone_repository]` — clone the original repository into a new directory possessing its own copy of the original project’s history
2. First person: `git commit -a` — add file to the _staging area_ of the [clone_repository]
3. Second person: `git pull [clone_repository] master` — fetch changes from the remote branch (1. person) and merge them into the current branch (2. person);
   better:
   `git fetch [clone_repository] master` `git log -p HEAD..FETCH_HEAD` — fetch changes and show everything reachable from the FETCH_HEAD of the [clone_repository] and exclude everything reachable from the HEAD of the [original_repository]
4. Second person: `gitk HEAD..FETCH_HEAD` — visualize change history, everything that is reachable from either one, but exclude anything that is reachable from both of them

... [Remote Repo](https://git-scm.com/docs/gittutorial)

## Git terminology

_**Branch:**_ A lightweight movable pointer to a commit

_**Checkout:**_ Switch between branches in a repository

_**Clone:**_ A local version of a repository, including all commits and branches

_**Commit:**_ A Git object, a snapshot of an entire repository compressed into a SHA

_**Conflict:**_ Change at the same line of code

_**HEAD:**_ Representing the current working directory, the HEAD pointer can be moved to different branches, tags, or commits when using `git checkout`

_**Fork:**_ A copy of a repository on GitHub owned by a different user

_**Local:**_ A local version of a remote repository

_**Master:**_ The main version of a project

_**Merge:**_ Put contents from a branch into the master

_**Merge commit:**_ A commit with **two** parents

_**Origin:**_ Origin is a reference to the remote repository from which a project was initially cloned

_**Pull request:**_ A place to compare and discuss the differences introduced on a branch with reviews, comments, integrated tests, and more

_**Push:**_ Upload local repository content to a remote repository

_**Remote:**_ A common repository (on GitHub) that all team members use to exchange their changes

_**Rebase:**_ A sequence of commits is combined to a new base commit (parent)

_**Repository:**_ A folder optimized for version control

_**Staging area:**_ Also called **stage** or **index**, is a intermediate area where commits can be formatted and reviewed before completing the commit

_**Stashing:**_ Switch branch without committing the current branch

_**Tag:**_ Tags make a point as a specific point in Git history and are used to mark a commit stage as important

## References

- [Discover character entries at &what](https://www.amp-what.com/unicode/search/emoticon)
- [Git](https://git-scm.com/)
- [Visual Git cheat sheet](https://ndpsoftware.com/git-cheatsheet.html)
- [Git Cheat Sheets](https://github.github.com/training-kit/)
- [GitHub Guides](https://guides.github.com/)
- [Duplicating a repository](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository)
- [Frontend Masters Course: Advanced Git](https://github.com/nnja/advanced-git)
