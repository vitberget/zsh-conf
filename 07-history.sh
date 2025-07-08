HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh-history
setopt HIST_IGNORE_SPACE
setopt interactivecomments

function no_history_with_this_comment() {
 if [[ $1 == *'# NO HISTFILE' ]]; then
     return 1
 fi
}

add-zsh-hook zshaddhistory no_history_with_this_comment

addNoComment() {
    RBUFFER="$RBUFFER # NO HISTFILE"
}

zle -N addNoComment
bindkey '^[^Z' addNoComment
