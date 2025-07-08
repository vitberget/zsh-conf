addSudo() {
    LBUFFER="sudo $LBUFFER"
}

zle -N addSudo
bindkey '^[^X' addSudo
