#!/usr/bin/env fish
# pre-commit.fish - A fish shell git pre-commit hook
# This hook runs various checks before allowing a commit

# Prevent commit to main/master branch directly
set -l branch (git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
set -l protected_branches "main master develop"

for protected_branch in $protected_branches
    if test "$branch" = "$protected_branch"
        echo "⛔ Direct commits to $protected_branch branch are not allowed!"
        echo "Please create a branch and submit a pull request instead."
        exit 1
    end
end

# Success
exit 0
