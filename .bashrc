export PATH=/usr/bin:/usr/local/bin:/opt/local/bin:$PATH
export EDITOR=vim

echo "running profile"

parse_git_branch() {
    BRANCH=`echo $(__git_ps1) | sed -e s/[\(\)]//g`
    echo $BRANCH | egrep "(bug|ticket|refactor|feature)/.+/[0-9]+.+" > /dev/null
    if [ $? == 0 ]
   # then echo $BRANCH | sed -e 's/\(.*\/.*\/[0-9]*\).*/ [\1]/'
    then echo $BRANCH | sed -e 's/\(.*\/.*\/[0-9]*.*\).*/ [\1]/'
    elif (( ${#BRANCH} > 0 ))
    then echo " ($BRANCH)"
    fi
}

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

PS1='$? \w\[\e[32m\]$(parse_git_branch)\[\e[36m\] \[\e[0m\] \$ '

. /opt/boxen/env.sh