FROM ubuntu:focal-20250404


ARG BASTION_IMAGE
ARG BASTION_IMAGE_VERSION

ENV BASTION_IMAGE=${BASTION_IMAGE:-undefined}
ENV BASTION_IMAGE_VERSION=${BASTION_IMAGE_VERSION:-undefined}



RUN echo "Acquire { HTTP::proxy \"$http_proxy\"; HTTPS::proxy \"$https_proxy\"; }" > /etc/apt/apt.conf.d/proxy.conf \
	&& apt-get update \
    && apt-get install --yes software-properties-common \
    && add-apt-repository --yes --update ppa:ansible/ansible \
    && add-apt-repository --yes --update ppa:deadsnakes/ppa \
    && apt-get install --yes ansible sudo xmlstarlet




RUN useradd cloud -m \
    && echo "cloud ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/cloud


COPY ansible /.ansible
RUN cd /.ansible \
    && ls -al \
    && chmod 755 . \
    && ansible-playbook -i local-inventory setup-bastion.yml \
    && cd / \
    && rm -rf /.ansible \
    && mv /home/cloud /.initial-cloud-home 

USER cloud

COPY entrypoint.sh /entrypoint.sh


ENTRYPOINT /entrypoint.sh
