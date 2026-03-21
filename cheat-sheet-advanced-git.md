# Advanced Git

## Git foundations

### Data storage

- Git is like a key-value store
  - key = data
  - value = hash of the data
- The key (SHA1)
  - can be used to retrieve the content
  - is a cryptographic hash function
  - produces a 40-digit hexadecimal number when given data
  - the value should always be the same if given input is the same
  - also called content-addressable storage system because the content can be used to generate the key
- three types of objects:
  - blobs
  - trees
  - commits

**Example `.git` directory**

```sh
$> tree .git

.git
├── COMMIT_EDITMSG
├── HEAD # usually points to the current branch / commit
├── config
├── description
│── FETCH_HEAD
├── index
│── ORIG_HEAD
│── packed-refs
│── hooks
├── info
│   └── exclude
├── logs
│   ├── HEAD
│   └── refs
│       └── heads
│           └── master
├── objects
│   ├── 43
│   │   └── 388fee19744e8893467331d7853a6475a227b8
│   ├── 58
│   │   └── 1caa0fe56cf01dc028cc0b089d364993e046b6
│   ├── 98
│   │   └── 0a0d5f19a64b4b30a87d4206aade58726b60e3
│   ├── info
│   └── pack
└── refs
    ├── heads
    │   └── branch_a
    │   └── branch_b
    │   └── master
    │── remotes
    └── tags
```

### Blobs & trees

#### Blobs

- blobs are unique
- blobs are stored in the object directory of `.git` as a subdirectory starting with the first two chars of the hash
- Git stores the compressed data in a blob, along with metadata in the header
  - identifer **blob**
  - size of content
  - /0 delimiter
  - content
- Git hash object
  - asking for the SHA1 of contents ` ... git hash-object --stdin`
  - generating the SHA1 of the contents, with metadata `... openssl sha1`
  - when running a cache method the same result is always achieved

#### Trees

- info on filenames and directory structures are stored in a tree
- trees contain pointers (using SHA1) to blobs and other trees (directed graph)
- trees also contains metadata
  - type of pointer (blob or tree
  - filename or directory name
  - mode (executable file, symbolic link, etc.)
- identical content is only stored once -> saving tons of space on hd

### Commits

- commits point to a tree and contain metadata on
  - author and committer
  - data
  - message
  - parent commit (>= 1)
- the SHA1 of the commit is the hash of all that info
- commits are code snapshots
- commits can not be changed --> history manipulation
- when edited a new SHA1 hash is assigned (even if files do not change, the created date will)

### References

- references are pointers to commits
  - tags
  - branches
  - HEAH - a pointer to the current commit, the last commit made (special type of pointer)
- changing branches is fast, since only pointers are changed

> **NOTE:** Simple repo has 1 tree, 1 blob, and 1 commit. Object content (blob, tree, commit) is compressed and can not be read with a simple `cat` command, instead `git cat-file`.

## Git areas & staging

### Working area

- untracked files
- files ready for staging

### Staging area

- also called **index** or **cache**
- files to be part of the next commit
- diff between current and last commit
- a "clean" staging area is not empty
- baseline staging area contains a copy of the files of the latest commit and the assigned SHA1
- index is a binary file in the Git repo
- unstaged files are not removed, but replaced by a copy

### Repo

- contains all commits

### Staging

- save uncommitted work
- safe from destructive operations, e.g. switching between branches

## References, commits & branches

- pointers to commits
- three types of references
  - tags & annotated tags
  - branches
  - HEAH

### Branches

- is a pointer to a particular commit
- the current branch pointer moves with every commit to the repo

### HEAD

- indicates current branch (Git knows what the next parent will be)
- points at the name of the current branch
- can point at a commit (= detached HEAD)
- moves when
  - a new commit is made in the currently active branch or
  - a new branch is checked out
- HEAD-less or detached HEAD
  - specific commit checkout moves HEAD to this commit
  - the HEAD will point to a new SHA1
  - no references pointing to the commits made (detached state)
- solution to detached HEAD
  - create new branch pointing to the last commit `git branch [new_branch] [commit]` (the last commit because the other ones point to their parents)
  - discard changes (dangling commits), which will be garbage collected -> no longer referenced in Git

### Tags

- lightweight tags are simple pointers to a commit
- tags with no argument -> value is captured in the HEAD
- annotated tags `git tag -a`
  - point to a commit
  - have additional info such as author, message, date
  - not commonly used
- the commit a tag points to does not change (snapshot)

## Merging & rebasing

- merge commits are markers
- merge commits can have several parents
- fast-forward commit: new commits are added on top of the master branch and the master pointer is moved automatically (linearized commit)
- the history of a merge commit can be retained by `git merge [branch] --no-ff` --> merge commit will be forced
- merge conflicts
  - attempt to merge, but files have diverged
  - Git stops until conflicts are resolved
- **Git RERERE** — reuse recorded resolution
  - Git saves how conflicts were resolved and applies it again
  - useful for refactoring, rebasing
  - `git config rerere.enabled true`, use flag `--global` for all projects

## History & diffs

- good commits help to preserve the history of a code base, etc.
- good commit messages
  - encapsulates one logical idea
  - have a title and body with a precise description of the current behavior, the purpose of the fix, and side effects
  - are in future tense
  - broken into 72 char lines

## Fixing mistakes

### Git checkout

- restore working tree files (moving the HEAD pointer)
- switch branches (moving the HEAD pointer to the new branch)
- files (no pointer moving)

### Git clean

- cleans working area by deleting all untracked files permanently

### Git reset

- performs different actions depending on the arguments
  - with a path
  - without a path
- default: `git reset --mixed`
- commits
  - moves the HEAD pointer and the branch reference
  - optionally modifies files
- file paths
  - moves the HEAD pointer and modifies files
- three types:
  - soft: HEAD
  - mixed: HEAD + staging area
  - hard: HEAD + staging area + working area
- can change history
  Git keeps the previous value of HEAD in a variable called **ORIG_HEAD**
  so in case of an accidental reset, the original state (HEAD) can be restored

> **NOTE:** Never push changed history to a shared or public repo.

### Git revert

- the "safe" reset
- revert does not change history
- creates a new commit that introduces the opposite changes from the specified commit
- the original commit stays in the repo
- used to undo a commit that has already been shared

## Rebase & amend

### Git amend

- amend is useful to make changes to the previous commit
- every amend leads to a new commit with a different date
- when amending, the original commit and amended commit (copy of the original commit) have different SHAs, since commits can not be edited
- the original commit has no references pointing to it and will be garbage collected

### Git rebase

- a commit gets a new base commit (parent)
- useful when feature branch and master have diverged
- all latest changes are pulled in from the master and copies of own commits are applied on top of them by changing the parent commit of the own commits (`git rebase master`)
- the feature branch is then up-to-date
- advantages
  - commits can be edited
  - commits can be removed
  - commits can be combined
  - commits can be reordered
  - commits can be inserted and are then replayed on top of the new HEAD
  - fix previous mistakes in code
  - Git history is kept neat and clean
- interactive rebase with `-i` or `--interactive` flag
  - opens an editor with a list of to-dos
  - commits are picked in the specified order
  - format: `[command] [commit] [commit_message]`
  - interactive rebase with a shortcut `git rebase -i [commit_to_fix]^` (the `^` specifies the parent commit)
- useful to split commits into multiple ones
- rebase with command execution
  - `git rebase -i --exec "run-tests" [commit]`
  - used as a flag when rebasing
  - execute specified command when doing interactive rebase
  - stops in case of failure

### Abort

- before rebase is done, if things are going wrong
- before rebasing, make a copy of the current branch by creating a new branch `git branch [branch_backup]`
- if rebase succeeds but messed up `git reset [branch_backup] --hard`

> **BEST PRACTICE:** Commit often, perfect later, publish once. Before pushing work to a shared repo, rebase to clean up the commit history.

## Remote repos & forks

### Remotes

- remote is a Git repo stored on the web, in GitHub
- **origin** is the default name of a remote Git gives to the server the repo was cloned from
- cloning means fetching the whole repo and making it a local copy
- remotes options are read & write or read only

### Forks

- a fork is a copy of a repo stored in a GitHub account
- forks can be cloned to a local computer
- read & write options
- merging changes to original via pull requests
- stay up-to-date with an upstream
  - upstream repo is the base repo the fork was created from
  - set up an upstream to pull down changes after forking the base repo `git remote add upstream [url]`

## References

- [Frontend Masters Course: Advanced Git](https://github.com/nnja/advanced-git)
