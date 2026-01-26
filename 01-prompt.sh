bindkey -v

function git-prompt-prompt() {
    eval $(git-prompt 2>/dev/null)
    if [[ ! -z "$GIT_PROMPT_BRANCH" ]]; then
        if [[ "$GIT_PROMPT_REMOTE" == "same" ]]; then
            echo -n "%F{249}\uE0A0${GIT_PROMPT_BRANCH}"
        else
            echo -n "%F{160}\uE0A0%F{249}${GIT_PROMPT_BRANCH}"
        fi
        if [[ "$GIT_PROMPT_INDEX_CHANGED" == "true" ]]; then
            echo -n "%F{red}✗"
        else
            echo -n "%F{green}✓"
        fi
        if [[ "$GIT_PROMPT_WORKTREE_CHANGED" == "true" ]]; then
            echo -n "%F{red}✗"
        else
            echo -n "%F{green}✓"
        fi
        echo " "
    fi
}

function venv-prompt() {
    if [[ ! -z "$VIRTUAL_ENV_PROMPT" ]]; then
        echo -n " %F{144}%{\x1b[3m%}$VIRTUAL_ENV_PROMPT%{\x1b[0m%}"
    fi
}

function yocto-prompt() {
    if [[ ! -z "$BBPATH" ]]; then
        YOCTO_NAME=$(basename $(dirname $BBPATH))
        echo -n " %F{144}%{\x1b[3m%}$YOCTO_NAME%{\x1b[0m%}"
    fi
}

function zsh-prompt-user() {
    if [ "$(whoami)" = "root" ]; then
        echo "%F{red}%B%n%b"
    else   
        echo "%F{111}%n"
    fi
}

function zsh-prompt-hostname() {
    if [[ $SSH_CONNECTION ]]; then
        echo "%F{214}💻%F{${PROMPT_HOSTNAME_COLOR:=249}}%m "
    fi
}

function zsh-tmux() {
    if [ -v TMUX ]; then
        echo -n "%F{144}"
        tmux display -p "[tmux #S:#{window_index}] "
    fi
}

function zsh-prompt-cpath() {
    echo "%B%F{172}%60<...<%~%<<%b"
}

function zsh-prompt-ins-norm-mode() {
    case $KEYMAP in
        vicmd) echo "%F{214}%B+ %b";;
        *) echo "%F{#AAAAAA}%B\u00BB %b";;
    esac
}

function zsh-prompt-kube() {
    if [ -v KUBE_PROMPT_ON ]; then
        KUBE_PROMPT_CONTEXT=$(kubectl config current-context 2>/dev/null)
        KUBE_PROMPT_NAMESPACE=$(kubectl config view --minify --output 'jsonpath={..namespace}')

        echo -n "%F{27}⎈ "
        echo -n "%F{99}${KUBE_PROMPT_CONTEXT}"
        echo -n "%F{8}:"
        echo -n "%F{218}${KUBE_PROMPT_NAMESPACE} "
    fi
}
kube-on() {
    export KUBE_PROMPT_ON
}
kube-off() {
    unset KUBE_PROMPT_ON
}

ZLE_RPROMPT_INDENT=0

function zsh-exit-status() {
    echo '%(?..%F{red}%? )'
}

function zsh-right-prompt() {
    if [[ "$PROMPT_TIME_SHOW" == "true" ]]; then
        RPROMPT="%F{247}%D{%Y-%m-%f} %F{252}%*"
    else
        RPROMPT=""
    fi
}
function zsh-prompt() {
    PROMPT="$(zsh-prompt-hostname)$(zsh-tmux)$(zsh-prompt-user) $(zsh-prompt-kube)$(git-prompt-prompt)$(zsh-exit-status)$(zsh-prompt-cpath)$(venv-prompt)$(yocto-prompt)"$'\n'"$(zsh-prompt-ins-norm-mode)"
}

function zsh-prompt-reset-cursor() {
    echo -ne '\e[6 q'
}

function zle-keymap-select {
    case $KEYMAP in
        vicmd)       
            zsh-prompt
            echo -ne '\e[2 q'
            ;;
        *)           
            zsh-prompt
            echo -ne '\e[6 q'
            ;;
    esac

    zle reset-prompt
}

function zsh-prompt-reset-colors() {
    #echo -ne 'hello'
    tput sgr0
}

function zsh-prompt-window-title() {
    if [[ $SSH_CLIENT ]]; then
		echo -ne "\033]0;[${USER}@${HOST}] ${PWD/#$HOME/~}\007"
	else
		echo -ne "\033]0;${PWD/#$HOME/~}\007"
    fi
}

zle -N zle-keymap-select

precmd_functions+=(zsh-prompt)
precmd_functions+=(zsh-right-prompt)
precmd_functions+=(zsh-prompt-reset-cursor)
preexec_functions+=(zsh-prompt-reset-colors)
precmd_functions+=(zsh-prompt-window-title)

