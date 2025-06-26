alias kc='kubectl'

function kube-namespace() {
    if [ -n "$1" ]; then
        kubectl config set-context --current --namespace="$1"
    else
        kubectl get namespace | grep Active | awk '{ print $1 }'
    fi
}
