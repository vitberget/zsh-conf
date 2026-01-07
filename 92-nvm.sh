if [ -f /usr/share/nvm/init-nvm.sh ]; then
    alias init-nvm='source /usr/share/nvm/init-nvm.sh'
elif [ -f "$NVM_DIR/nvm.sh" ]; then
    alias init-nvm='source $NVM_DIR/nvm.sh'
fi

function chpwd_init_nvm_on_nvmrc() {
    if [[ -f ".nvmrc" ]]; then
        if ! whence nvm >/dev/null 2>/dev/null ; then
            init-nvm
        fi
    fi
}

chpwd_functions+=(chpwd_init_nvm_on_nvmrc)
