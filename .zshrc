autoload -U colors && colors

if [ -d  "${HOME}/.config/zshrc-local.d" ]; then
    for e in "${HOME}/.config/zshrc-local.d"/*.sh; do
        . "${e}"
    done
fi


for e in "${HOME}/.config/zshrc.d"/*.sh; do
    . "${e}"
done

SOURCE_FILES=(
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
    /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)
for SOURCE_FILE in $SOURCE_FILES; do
    if [ -f $SOURCE_FILE ]; then 
        source $SOURCE_FILE
    fi
done

# if command -v helm >/dev/null 2>&1 ; then
# source <(helm completion zsh)
# fi

# source ~/.i18n
