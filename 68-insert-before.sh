# addDevour() {
#     LBUFFER="devour $LBUFFER"
# }

addSudo() {
    LBUFFER="sudo $LBUFFER"
}

zle -N addSudo
# zle -N addDevour

bindkey '^[^X' addSudo
# bindkey '^[^Z' addDevour
