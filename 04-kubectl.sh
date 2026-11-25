function kube-namespace() {
    if [ -n "$1" ]; then
        kubectl config set-context --current --namespace="$1"
    else
        NAMESPACE=$(kubectl get namespace | grep Active | awk '{ print $1 }' | fzf 2>/dev/null)
        if [ -n "$NAMESPACE" ]; then
            kubectl config set-context --current --namespace="$NAMESPACE"
        fi
    fi
}

function kube-select {
    if [ -n "$1" ]; then
        local SOURCE="$1"
    else
        local SOURCE=$(find ~/.kube  -maxdepth 1  -iname "*.yaml" -printf "%f\n" | sed -e 's/\.yaml//' | fzf)
    fi

    export KUBECONFIG=$HOME"/.kube/${SOURCE}.yaml"
    kube-on
}

function kube-copy {
    if [ -n "$1" ]; then
        local SOURCE="$1"
    else
        local SOURCE=$(find ~/.kube  -maxdepth 1  -iname "*.yaml" -printf "%f\n" | sed -e 's/\.yaml//' | fzf)
    fi

    mkdir -p ~/.kube/tmp/ > /dev/null
    local RAND=$(cat /dev/random | base64 | tr -dc '0-9a-zA-Z' | head -c20)
    local DATETIME=$(date '+%Y-%m-%d_%H.%M.%S')
    export KUBECONFIG=$HOME"/.kube/tmp/nya_${DATETIME}_${RAND}.yaml"
    cp ~/.kube/${SOURCE}.yaml ${KUBECONFIG}
    kube-on
}

alias kube-ns=kube-namespace
alias kc-ns=kube-namespace
alias kc=kubectl
alias kc-select=kube-select
alias kc-copy=kube-copy
