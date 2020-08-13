#!/bin/sh
set -x
# In Openshift, user is non-root but belongs to the root group.
# So set umask to put RW on the group for created files
echo "Setting umask"
umask 007

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "Adding entry in /etc/passwd for OpenShift arbitrary User ID"
#    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default}:/home/:/bin/bash --rcfile /.bashrc" >> /etc/passwd
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default}:/home/:/bin/fish" >> /etc/passwd
    alias helm2="/helm2/helm"
    alias helm3="/helm3/helm"
    alias bash="bash --rcfile /.bashrc"
  fi   
fi    
tail -f /dev/null

