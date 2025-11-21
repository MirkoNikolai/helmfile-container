FROM docker.io/library/almalinux:10.0-minimal

WorkDir /tmp

RUN microdnf update
# need packages
RUN microdnf -y install wget tar bzip2 sudo openssl git curl
# install helmfile 
RUN wget https://github.com/helmfile/helmfile/releases/download/v1.1.9/helmfile_1.1.9_linux_amd64.tar.gz  
RUN tar xvzf helmfile_1.1.9_linux_amd64.tar.gz 
RUN mv helmfile /usr/local/bin/
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"  
RUN chmod +x kubectl 
RUN mv kubectl /usr/local/bin
# install bao
RUN wget https://github.com/openbao/openbao/releases/download/v2.4.3/bao-hsm_2.4.3_Linux_x86_64.tar.gz
RUN tar xf bao-hsm_2.4.3_Linux_x86_64.tar.gz
RUN mv bao /usr/local/bin/
# init helmfile
RUN helmfile init --force
# clean up
RUN rm -rf /tmp/*
RUN microdnf clean all
