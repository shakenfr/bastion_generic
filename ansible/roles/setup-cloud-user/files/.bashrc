### Add Git Status to bash prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n$ "
alias bash="bash --rcfile /.bashrc"
alias ll="ls -al"
alias k=kubectl
alias kk="kustomize build .|kubectl apply -f -"
alias help="echo list of available commands added : - argocd-plugin , arkade, dnsmasq, helm, k9s, kubectl, oc, kubent, kubewire, kustomize, mongo client, mongo tools, sendmail.pl, terraform, trivy, vault, vim, curl, wget, git, python3, unzip, gcc, ksh, telnet, openssh, busybox, strace, openssl, netcat, fish, golang, rclone, yq, jq"
alias oct="export KUBECONFIG=/home/cloud/openshift.conf;oc config use-context btd-tools"
alias ocs="export KUBECONFIG=/home/cloud/openshift.conf;oc config use-context btd-sandbox"
alias btdkube="export KUBECONFIG=/home/cloud/kubernetes.conf;kubectl config use-context btdadmin"
alias kgpo="kubectl get pods"
alias kgcm="kubectl get cm"
alias kgcf="kubectl config view"
alias kgse="kubectl get secrets"
alias kgsv="kubectl get services"
alias kgde="kubectl get deployment"
alias kgss="kubectl get statefulset"
alias kuc="kubectl config use-context"
alias python="/usr/bin/python3.10"
echo "list of available commands added :"
echo " - argocd-plugin ; arkade; dnsmasq; helm; k9s; kubectl; oc; kubent; kubewire; kustomize; mongo client; mongo tools; sendmail.pl; terraform; trivy; vault; vim; curl; wget; git ; python3; unzip; gcc; ksh ; telnet; openssh; busybox; strace; openssl; netcat; fish; golang; rclone; yq; jq"
export PATH=$PATH:/app/nodejs/bin
alias 
#### Change terminal title
[ -f /.local/source_env.sh ] && source /.local/source_env.sh
PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'

. /usr/share/bash-completion/bash_completion
complete -F __start_kubectl k

# Move to $HOME (container is initially launched on / to permit /home/cloud initialization on empty /home)
cd $HOME

# Outputs only on interactive session (else it affects ansible)
if [ -t 0 ]
then
	echo "Using bastion image $BASTION_IMAGE_VERSION ($BASTION_IMAGE)"
fi
