### Add Git Status to bash prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n$ "
alias helm2="/helm2/helm"
alias helm3="/helm3/helm"
#### Change terminal title
PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'

