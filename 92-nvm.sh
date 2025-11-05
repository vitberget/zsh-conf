if [ -f /usr/share/nvm/init-nvm.sh ]; then
    alias init-nvm='source /usr/share/nvm/init-nvm.sh'
elif [ -f "$NVM_DIR/nvm.sh" ]; then
    alias init-nvm='source $NVM_DIR/nvm.sh'
fi
