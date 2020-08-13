# bastion

Toolbox for exploit
  
to connect :
  
oc login URL --token <PERMANENT_TOKEN>
oc rsh deploy/bastion bash --rcfile /.bashrc
or
oc rsh deploy/bastion fish    (better !)
             
after you can go to /home to do what you want

Tools inside :

git
terraform +some plugin  for kiban
ansible
telnet
scp
sftp
mongo client
python2
python3
gcc
sshpass
expect
oc
kubectl
eoc
ksh
bash
perl
fish
nvi
joe
vim
curl & wget
netcat
openssl
busybox

To install bastion on openshift

oc apply -f pvc.yaml
oc apply-f sa.yaml
oc apply -f rbac.yaml
oc apply -f deployment.yaml

