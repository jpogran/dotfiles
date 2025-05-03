# Git utility functions

function gclean --description "Clean local branches that have been merged to main/master"
    set -l main_branch main
    if not git show-ref --quiet refs/heads/main
        set main_branch master
    end

    echo "Cleaning branches merged to $main_branch..."
    git checkout $main_branch
    git fetch -p
    git branch --merged | grep -v "\*" | grep -v $main_branch | xargs -n 1 git branch -d
end

function gsync --description "Sync current branch with remote"
    set -l current_branch (git rev-parse --abbrev-ref HEAD)
    set -l main_branch main
    if not git show-ref --quiet refs/heads/main
        set main_branch master
    end

    echo "Syncing branch $current_branch with $main_branch..."
    git fetch --all --prune
    git checkout $main_branch
    git pull origin $main_branch
    git checkout $current_branch
    git rebase $main_branch
end

function gswitchto --description "Switch to a branch, creating it if it doesn't exist"
    set -l branch $argv[1]
    if git show-ref --quiet refs/heads/$branch
        git checkout $branch
    else
        git checkout -b $branch
    end
end
