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

alias kc='kubectl'
alias kc-namespace=kube-namespace
