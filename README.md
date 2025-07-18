# new version to include rclone tool
you have to put first rclone.conf as a secret inside the same target namespace
command is :
kubectl create secret generic rclone --from-file=rclone.conf
after you have to install bastion-light into your target namespace
cd manifest
cd tool-DEV
kustomize build . |kukectl apply -f -
inside bastion-light you can access to s3 with :
rclone --config=/rclone/rclone.conf ls S3FE:/

# Bastion component for BTD

This repository is used to build and deploy the bastion component within the BTD platform.

Bastion contains a set of tools which are installed using Ansible (Kubernetes tools, DB clients, ...).

Bastion is both provided as a Docker image, and as a VM deployed in Flexible Engine with Terraform.

# Prerequites

create secrets inside the target namespace (btd) to retrieve keys/token to access 
ntral repository , openshift access and btd kubernetes access

After that you can create the secret inside tools's namespace.

kubectl create secret docker-registry gitlab-btd-registries \
     --docker-server=registry.gitlab.tech.orange \
     --docker-username=bot-107501 \
     --docker-password=<HERE_THE_RETRIEVE_PASSWORD> \
     --docker-email=unused --dry-run -o yaml > secret-gitlab-btd-registries.yaml

kubectl apply -f secret-gitlab-btd-registries.yaml

or kubectl create secret generic central-repository --from-file=your file taken from vault



# Launch

when you are inside the BTD kube cluster

kubectl exec -ti bastion-0 bash



