# git
## Setup and Config
git version 2.36.1
#### config
> git config --global user.email 'ag14341@gmail.com'
> 
> git config --global user.name 'ag143'
#### help
#### bugreport
## Getting and Creating Projects
#### init
#### clone
## Basic Snapshotting
#### add
#### status
#### diff
#### commit
#### notes
#### restore
#### reset
#### rm
#### mv
> git mv test.txt rename.txt--> properly works in linux
## Branching and Merging
#### branch
#### checkout
#### switch test
#### merge
#### mergetool
#### log
#### stash
#### tag
#### worktree
## Sharing and Updating Projects
#### fetch
#### pull
#### push
#### remote
#### submodule
## Inspection and Comparison
#### show
#### log
#### diff
#### difftool
#### range-diff
#### shortlog
#### describe
## Patching
#### apply
#### cherry-pick
#### diff
#### rebase
#### revert
## Debugging
#### bisect
#### blame
#### grep
.github/workflows/main.yml:    runs-on: ubuntu-latest
.github/workflows/main.yml:          echo test, and deploy your project.
git_guide.md:> git mv test.txt rename.txt--> properly works in linux
git_guide.md:#### switch test
git_guide.md:.github/workflows/main.yml:    runs-on: ubuntu-latest
git_guide.md:.github/workflows/main.yml:          echo test, and deploy your project.
git_guide.sh:echo "> git mv test.txt rename.txt--> properly works in linux">>git_guide.md
git_guide.sh:#git mv test.txt rename.txt >>git_guide.md
git_guide.sh:echo "#### switch test" >>git_guide.md
git_guide.sh:#git switch test >>git_guide.md
git_guide.sh:git grep test >> git_guide.md
git_training/README.md:If we have a look at the `git log` we'll not only see a list of all the commits with their _hash_ as well as _Author_ and _Date_, we also see the state of our _Local Repository_ and the latest local information about _remote branches_. 
git_training/README.md:* The latest commit in the _Local Repository_ is the one we just made, and now we know its hash.
git_training/README.md:When a branch is diverging from the one it's based on and you want to integrate the latest changes back into your current branch, `rebase` offers a cleaner way of doing that than a `merge` would. 
git_training/README.md:After that it does a `checkout` of the latest commit of the branch you're rebasing on, and then applies each of the stored changed __as a new commit__ on top of that.
git_training/README.md:In fact the _0cfc1d2_ commit is gone, and the `add_patrick` branch starts with a new _0ccaba8_ commit, that has the latest commit of _master_ as its ancestor. 
git_training/README.md:The commands you'll mostly use are `git stash` which places any modifications to the _Working Directory_ on the stash, and `git stash pop` which takes the latest change that was stashed and applies it the to the _Working Directory_ again. 
git_training/README.md:Just like the [stack commands](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) it's named after, `git stash pop` removes the latest stashed change before applying these changes to the working directory. 
git_training/README.md:If you want to keep the stashed changes, you can use `git stash apply`, this applies the latest stashed changes to the working directory without removing them from the stash. 
git_training/README.md:To inspect your current `stash` you can use `git stash list` to list the individual entries, and `git stash show` to show the changes in the latest entry on the `stash`. 
git_training/README.md:As any _local_ branch is based on its respective _remote_ version, we can also `rebase` it, so that any changes we may have made locally, appear as if they were based on the latest version that is available in the _Remote Repository_. 
git_training/README.md:`Amend`ing the latest commit basically works just like making a new one. 
git_training/README.md:Before we do anything, take a look at your latest commit, with `git show {COMMIT}`. Put either the commit hash (which you'll probably still see in your command line from the `git commit` call, or in the `git log`), or just _HEAD_.
git_training/README.md:What happens next is your latest commit being unrolled, the new changes from the _Staging Area_ added to the existing one, and the editor for the commit message opening. 
git_training/README.md:After you're done, take another look at the latest commit with `git show HEAD`.
git_training/README.md:While all the small atomic changes make it very easy for you to e.g. verify that with each change your test-suite still passes and if it doesn't, remove or amend just these specific changes, the 100 commits you've made to write `HelloWorld.java` are probably not something you want to share with people. 
nvie/README.md:Shows the commit SHA for the latest commit.
nvie/README.md:checking out all local branches one-by-one and pulling the latest upstream
nvie/git-merge-status:    test $empty -eq 0
nvie/git-modified:    test $empty -eq 0
nvie/git-modified-since:    test $empty -eq 0
nvie/git-show-skipped:    test $num_changed -eq 0
nvie/git-update-all:                echo "updated '$branch' to latest '$remote/$branch' ($orig_sha...$new_sha)"
refered1/readme.md:`git pull` pulls the latest content and merges it.
refered1/readme.md:#### Pull the latest content of the remote branch
refered1/readme.md:# Compare the difference between the latest submissions of the two branches, the develop branch and the master branch, if there is no difference, return empty
refered1/readme.md:# Do not specify parameters to view the latest information by default
refered1/readme.md:git archive --output "./output.zip" master src tests
refered1/readme.md:| test | Unit test changes |
refered1/readme.md:# Unit test changes
refered1/readme.md:git commit -m "test: test login"
## Guides
#### gitattributes
#### Command-line interface conventions
#### Everyday Git
#### Frequently Asked Questions (FAQ)
#### Glossary
#### Hooks
#### gitignore
#### gitmodules
#### Revisions
#### Submodules
#### Tutorial
#### Workflows
#### All guides...
## Email
#### am
#### apply
#### format-patch
#### send-email
#### request-pull
## External Systems
#### svn
#### fast-import
## Administration
#### clean
#### gc
#### fsck
#### reflog
#### filter-branch
#### instaweb
#### archive
#### bundle
## Server Admin
#### daemon
#### update-server-info
## Plumbing Commands
#### cat-file
#### check-ignore
#### checkout-index
#### commit-tree
#### count-objects
#### diff-index
#### for-each-ref
#### hash-object
#### ls-files
#### ls-tree
#### merge-base
#### read-tree
#### rev-list
#### rev-parse
#### show-ref
#### symbolic-ref
#### update-index
#### update-ref
#### verify-pack
#### write-tree
working
