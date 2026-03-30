git_commit_with_message() {
    LBUFFER="git commit -m \""
    RBUFFER="\""
}

zle -N git_commit_with_message
bindkey '^Xgc' git_commit_with_message

bindkey -s '^Xgp' 'git push'
bindkey -s '^Xgs' 'git status\n'
bindkey -s '^Xga' 'git add '
