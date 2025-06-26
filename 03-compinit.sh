autoload -U compinit && compinit
zstyle ':completion:*' menu select
zmodload -i zsh/complist

#rm -f ~/.zcompdump
compinit

bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history
