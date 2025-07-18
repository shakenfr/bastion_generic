#!/bin/sh

echo "Starting bastion with image version $BASTION_IMAGE_VERSION"
sudo wget https://bootstrap.pypa.io/get-pip.py 
sudo python3.10 get-pip.py
sudo pip install robotframework==5.0.1
sudo pip install requests==2.28.1
sudo pip install osa==0.2.3
sudo pip install appdirs==1.4.4
sudo pip install CacheControl==0.12.6
sudo pip install chardet==4.0.0
sudo pip install colorama==0.4.4
sudo pip install contextlib2==0.6.0
sudo pip install distlib==0.3.1
sudo pip install distro==1.5.0
sudo pip install html5lib==1.1
sudo pip install idna==3.4
sudo pip install lockfile==0.12.2
sudo pip install msgpack==1.0.2
sudo pip install charset-normalizer==2.1.1
sudo pip install ordered-set==4.0.2
sudo pip install packaging==20.9
sudo pip install pep517==0.9.1
sudo pip install progress==1.5
sudo pip install pyparsing==2.4.7
sudo pip install pytoml==0.1.21
sudo pip install retrying==1.3.3
sudo pip install six==1.15.0
sudo pip install toml==0.10.2
sudo pip install pip==22.2.2
sudo pip install urllib3==1.26.12
sudo pip install webencodings==0.5.1
sudo pip install setuptools==63.2.0
wget https://bootstrap.pypa.io/get-pip.py
python3.10 get-pip.py
pip install robotframework==5.0.1
pip install requests==2.28.1
pip install osa==0.2.3
pip install appdirs==1.4.4
pip install CacheControl==0.12.6
pip install chardet==4.0.0
pip install colorama==0.4.4
pip install contextlib2==0.6.0
pip install distlib==0.3.1
pip install distro==1.5.0
pip install html5lib==1.1
pip install idna==3.4
pip install lockfile==0.12.2
pip install msgpack==1.0.2
pip install charset-normalizer==2.1.1
pip install ordered-set==4.0.2
pip install packaging==20.9
pip install pep517==0.9.1
pip install progress==1.5
pip install pyparsing==2.4.7
pip install pytoml==0.1.21
pip install retrying==1.3.3
pip install six==1.15.0
pip install toml==0.10.2
pip install pip==22.2.2
pip install urllib3==1.26.12
pip install webencodings==0.5.1
pip install setuptools==63.2.0

if [ ! -f /home/cloud/.bashrc ]
then
    echo "Initializing /home/cloud with /.initial-cloud-home"
    sudo mkdir -p /home/cloud
    tar cf - -C /.initial-cloud-home . | sudo tar xf - -C /home/cloud
else
	echo "/home/cloud already initialized (initial profile is in /.initial-cloud-home)"
fi

if [ ! -e /home/cloud/.kube/config -a -f /.kube.default/config ]
then
	echo "Initializing default /home/cloud/.kube/config with /.kube.default/config"
	cp /.kube.default/config /home/cloud/.kube/config
else
	echo "/home/cloud/.kube/config already initialized (default config is /.kube.default/config)"
fi
if [ ! -f /home/cloud/openshift.conf ]
then
       cp /openshift/config.yaml /home/cloud/openshift.conf
fi
if [ ! -f /home/cloud/kubernetes.conf ]
then
       cp /kube/admin.config /home/cloud/kubernetes.conf
fi
if [ ! -t 0 ]
then
    echo "Entering endless pause"
	echo "To log on this pod, execute: kubectl exec -it $HOSTNAME -- bash"
    tail -f /dev/null
else
	exec bash "$@"
fi
