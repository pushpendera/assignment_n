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