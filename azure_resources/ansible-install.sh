#!/bin/bash

# Install ansible and azure module
yum update -y
yum install -y python3-pip
pip3 install --upgrade pip
pip3 install "ansible==2.9.17"
pip3 install ansible[azure]

# Install Ansible az collection for interacting with Azure.
/usr/local/bin/ansible-galaxy collection install azure.azcollection
wget https://raw.githubusercontent.com/ansible-collections/azure/dev/requirements-azure.txt
pip3 install -r requirements-azure.txt

# Install azure cli
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo

yum install -y azure-cli
