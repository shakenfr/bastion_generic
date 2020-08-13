FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update -y && \
    apt-get install -y  \
        vim \    
        nvi \
        joe \
        apt-file \
        apt-transport-https \
        curl \
        wget \
        software-properties-common \
        ca-certificates \
        git \
        tzdata \
        binutils \
        squashfuse \
        fuse \
        python \ 
        python3 \
        unzip \
        gcc \
        zsh \
        bash \
        ksh \
        fish \
        build-essential \
        telnet \
        sshpass \
        expect \
        ansible \
        openssh-server \
        busybox \
        libssl-dev \
        openssl \
        dumb-init \
        python3-pip \
        python-dev \
        uidmap \
        netcat \
        #sudo \

    && rm -rf /var/lib/apt/lists/*
RUN chmod g=u /etc/passwd
RUN apt-file update
RUN wget http://mirrors.kernel.org/ubuntu/pool/main/o/openssl1.0/libssl1.0-dev_1.0.2n-1ubuntu5.3_amd64.deb
RUN wget https://releases.hashicorp.com/terraform/0.12.17/terraform_0.12.17_linux_amd64.zip
RUN unzip /terraform_0.12.17_linux_amd64.zip
RUN mv terraform /bin/
RUN chmod 777 /bin/terraform
RUN rm -f /terraform_0.12.17_linux_amd64.zip
RUN wget https://github.com/ewilde/terraform-provider-kibana/releases/download/v0.7.1/terraform-provider-kibana_0.7.1_linux_amd64.zip
RUN unzip /terraform-provider-kibana_0.7.1_linux_amd64.zip
RUN mv terraform-provider* /bin/
RUN chmod 777 /bin/terra*
RUN rm -f /terraform-provider-kibana_0.7.1_linux_amd64.zip
RUN apt-get install -y libssl-dev --reinstall 
RUN wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.6.19.tgz
RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
RUN cp kubectl /bin/
RUN chmod 777 /bin/kubectl
RUN wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.2-linux-amd64.tar.gz
RUN tar xvfz helm-v2.12.2-linux-amd64.tar.gz
RUN mv linux-amd64 helm2
RUN wget https://get.helm.sh/helm-v3.3.0-rc.2-linux-amd64.tar.gz
RUN tar xvfv helm-v3.3.0-rc.2-linux-amd64.tar.gz
RUN mv linux-amd64 helm3
RUN tar xvfz /mongodb-linux-x86_64-3.6.19.tgz
RUN rm -R helm-v2.12.2-linux-amd64.tar*
RUN rm -R helm-v3.3.0-rc.2-linux-amd64*
RUN cp /mongodb-linux-x86_64-3.6.19/bin/* /bin/
RUN rm -f mongodb-linux-x86_64-3.6.19.tgz
RUN wget https://github.com/openshift/origin/releases/download/v3.10.0/openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz
RUN wget https://github.com/shakenfr/cloud_tools/raw/master/eoc
RUN cp eoc /bin/
#COPY infra_config_passphrase /home/infra_config_passphrase
#COPY source_env.sh /home/source_env.sh
RUN apt install -y apt-transport-https ca-certificates curl software-properties-common
#RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
#RUN apt update
#RUN apt-cache policy docker-ce
#RUN apt install -y docker-ce
#RUN usermod -aG docker t
#RUN ulimit -n 65566
#RUN service docker start
RUN tar xvfz openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz
RUN cp /openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit/oc /bin/
RUN rm -R openshift*
COPY run.sh /tmp/run.sh
COPY .bashrc /.bashrc
COPY .bashrc /home/.bashrc
COPY profile /etc/profile
RUN rm -R /mongodb-linux-x86_64-3.6.19
RUN rm -f /libssl1.0-dev_1.0.2n-1ubuntu5.3_amd64.deb
RUN chmod 777 /.bashrc
RUN chmod 777 /tmp/run.sh
RUN mkdir -p /.kube
RUN chmod 777 /.kube
RUN chmod 777 /bin/eoc
ENTRYPOINT [ "/usr/bin/dumb-init", "--"]
CMD ["sh", "/tmp/run.sh"]

