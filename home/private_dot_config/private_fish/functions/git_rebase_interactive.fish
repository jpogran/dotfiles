function git_rebase_interactive --description 'Interactively rebase onto the latest commit of main'
  set branch main
  if not git show-ref --verify --quiet refs/heads/$branch
    echo "Branch '$branch' does not exist. Please check the branch name." >&2
    return 1
  end
  git rebase -i (git log --format=format:'%H' -n 1 $branch)
end
abbr --add gri 'git_rebase_interactive'
