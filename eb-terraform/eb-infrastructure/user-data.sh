#! /bin/bash
sudo apt update

##### Install kubectl #####
{
   curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
   echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
}
sudo apt update && sudo apt install -y kubectl=1.23.1-00

##### Install AWS CLI
sudo apt install awscli -y


##### Install EKSCTL #####
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
