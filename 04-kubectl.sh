function kube-namespace() {
    if [ -n "$1" ]; then
        export KUBE_NS="$1"
    else
        NAMESPACE=$(kubectl get namespace | grep Active | awk '{ print $1 }' | fzf 2>/dev/null)
        if [ -n "$NAMESPACE" ]; then
            export KUBE_NS="$NAMESPACE"
        fi
    fi
}

function kube-ctx-namespace() {
    if [ -n "$1" ]; then
        kubectl config set-context --current --namespace="$1"
    else
        NAMESPACE=$(kubectl get namespace | grep Active | awk '{ print $1 }' | fzf 2>/dev/null)
        if [ -n "$NAMESPACE" ]; then
            kubectl config set-context --current --namespace="$NAMESPACE"
        fi
    fi
}

function kc() {
    if [[ -v KUBE_NS ]]; then
        kubectl -n $KUBE_NS "$@"
    else
        kubectl "$@"
    fi
}

alias kc-namespace=kube-namespace
alias kube-ns=kube-namespace
alias kc-ns=kube-namespace

compdef _kubectl kc
