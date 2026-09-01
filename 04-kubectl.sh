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

alias kube-ns=kube-namespace
alias kc-ns=kube-namespace
alias kc=kubectl

