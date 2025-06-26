alias kc='kubectl'
alias kube-docker='export KUBECONFIG=~/.kube/docker.yaml; kube-on'
alias kube-rke2='export KUBECONFIG=~/.kube/rke2.yaml; kube-on'

function kube-namespace() {
    if [ -n "$1" ]; then
        kubectl config set-context --current --namespace="$1"
    else
        kubectl get namespace | grep Active | awk '{ print $1 }'
    fi
}
