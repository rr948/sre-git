echo "# git" >git_guide.md
echo "## Setup and Config" >>git_guide.md
git --version >>git_guide.md
echo "#### config" >>git_guide.md
echo "> git config --global user.email 'ag14341@gmail.com'" >>git_guide.md
echo "> ">>git_guide.md
echo "> git config --global user.name 'ag143'" >>git_guide.md
echo "#### help" >>git_guide.md
echo "#### bugreport" >>git_guide.md
echo "## Getting and Creating Projects" >>git_guide.md
echo "#### init" >>git_guide.md
echo "#### clone" >>git_guide.md
echo "## Basic Snapshotting" >>git_guide.md
echo "#### add" >>git_guide.md
echo "#### status" >>git_guide.md
echo "#### diff" >>git_guide.md
#git diff >>git_guide.md
echo "#### commit" >>git_guide.md
echo "#### notes" >>git_guide.md
#git notes >>git_guide.md
echo "#### restore" >>git_guide.md
echo "#### reset" >>git_guide.md
echo "#### rm" >>git_guide.md
echo "#### mv" >>git_guide.md
echo "> git mv test.txt rename.txt--> properly works in linux">>git_guide.md
#git mv test.txt rename.txt >>git_guide.md
echo "## Branching and Merging" >>git_guide.md
echo "#### branch" >>git_guide.md
#git branch >> git_guide.md
echo "#### checkout" >>git_guide.md
echo "#### switch test" >>git_guide.md
#git switch test >>git_guide.md
echo "#### merge" >>git_guide.md
echo "#### mergetool" >>git_guide.md
echo "#### log" >>git_guide.md
#git log >>git_guide.md
echo "#### stash" >>git_guide.md
echo "#### tag" >>git_guide.md
echo "#### worktree" >>git_guide.md
echo "## Sharing and Updating Projects" >>git_guide.md
echo "#### fetch" >>git_guide.md
echo "#### pull" >>git_guide.md
echo "#### push" >>git_guide.md
echo "#### remote" >>git_guide.md
echo "#### submodule" >>git_guide.md
echo "## Inspection and Comparison" >>git_guide.md
echo "#### show" >>git_guide.md
#git show >>git_guide.md
echo "#### log" >>git_guide.md
#git log >>git_guide.md
echo "#### diff" >>git_guide.md
#git diff >>git_guide.md
echo "#### difftool" >>git_guide.md
#git difftool >>git_guide.md
echo "#### range-diff" >>git_guide.md
echo "#### shortlog" >>git_guide.md
echo "#### describe" >>git_guide.md
#git describe >>git_guide.md
echo "## Patching" >>git_guide.md
echo "#### apply" >>git_guide.md
echo "#### cherry-pick" >>git_guide.md
echo "#### diff" >>git_guide.md
echo "#### rebase" >>git_guide.md
echo "#### revert" >>git_guide.md
echo "## Debugging" >>git_guide.md
echo "#### bisect" >>git_guide.md
echo "#### blame" >>git_guide.md
#git blame >>git_guide.md
echo "#### grep" >>git_guide.md
git grep test >> git_guide.md
echo "## Guides" >>git_guide.md
echo "#### gitattributes" >>git_guide.md
echo "#### Command-line interface conventions" >>git_guide.md
echo "#### Everyday Git" >>git_guide.md
echo "#### Frequently Asked Questions (FAQ)" >>git_guide.md
echo "#### Glossary" >>git_guide.md
echo "#### Hooks" >>git_guide.md
echo "#### gitignore" >>git_guide.md
echo "#### gitmodules" >>git_guide.md
echo "#### Revisions" >>git_guide.md
echo "#### Submodules" >>git_guide.md
echo "#### Tutorial" >>git_guide.md
echo "#### Workflows" >>git_guide.md
echo "#### All guides..." >>git_guide.md
echo "## Email" >>git_guide.md
echo "#### am" >>git_guide.md
echo "#### apply" >>git_guide.md
echo "#### format-patch" >>git_guide.md
echo "#### send-email" >>git_guide.md
echo "#### request-pull" >>git_guide.md
echo "## External Systems" >>git_guide.md
echo "#### svn" >>git_guide.md
echo "#### fast-import" >>git_guide.md
echo "## Administration" >>git_guide.md
echo "#### clean" >>git_guide.md
echo "#### gc" >>git_guide.md
echo "#### fsck" >>git_guide.md
echo "#### reflog" >>git_guide.md
echo "#### filter-branch" >>git_guide.md
echo "#### instaweb" >>git_guide.md
echo "#### archive" >>git_guide.md
echo "#### bundle" >>git_guide.md
echo "## Server Admin" >>git_guide.md
echo "#### daemon" >>git_guide.md
echo "#### update-server-info" >>git_guide.md
echo "## Plumbing Commands" >>git_guide.md
echo "#### cat-file" >>git_guide.md
echo "#### check-ignore" >>git_guide.md
echo "#### checkout-index" >>git_guide.md
echo "#### commit-tree" >>git_guide.md
echo "#### count-objects" >>git_guide.md
echo "#### diff-index" >>git_guide.md
echo "#### for-each-ref" >>git_guide.md
echo "#### hash-object" >>git_guide.md
echo "#### ls-files" >>git_guide.md
echo "#### ls-tree" >>git_guide.md
echo "#### merge-base" >>git_guide.md
echo "#### read-tree" >>git_guide.md
echo "#### rev-list" >>git_guide.md
echo "#### rev-parse" >>git_guide.md
echo "#### show-ref" >>git_guide.md
echo "#### symbolic-ref" >>git_guide.md
echo "#### update-index" >>git_guide.md
echo "#### update-ref" >>git_guide.md
echo "#### verify-pack" >>git_guide.md
echo "#### write-tree" >>git_guide.md
git config --global user.email "ag14341@gmail.com"
git config --global user.name "ag143"
echo "working" >>git_guide.md
git status
git add . 
git commit -m " Update o"
git push
