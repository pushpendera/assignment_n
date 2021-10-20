# nokia_assignment

## Task >> Setup single server K8s cluster and deploy an application of your choosing (nginx container) into it.

## Asumption 
- Ansible control machine is up and running and it has ansible installed on it. 
- For my assignment I will be creating one in Azure Cloud and will document steps for that as well.
- I will be using azure cloud for completing my assigment, however azure related steps can be ignored while reviewing the assignment. I am using azure to practically deploy the k8s single node cluster. 
- In case infrastructure is already ready jump to
link: [Step 2 Configure single node k8s](#step-2-configure-single-node-k8s)

# Step 1 - (Optional)
This step is optional. In case we have 2 servers already available then we can directly jump to k8s setup.
## Make ansible control machine
For making ansible control machine in azure make sure you have azure cli installed on your machine.

```bash
az group create --name nokia_assignment-rg --location northeurope

az vm create \
--resource-group nokia_assignment-rg \
--name ansiblectrl \
--image OpenLogic:CentOS:7.5:latest \
--admin-username ansibleuser \
--admin-password <password> \
--vnet-name ansiblectrlVNET \
--subnet ansiblectrlSubnet

az vm show -d -g nokia_assignment-rg -n ansiblectrl --query publicIps -o tsv

```

Note the IP of virtual machine and login to VM using

```bash 
ssh ansibleuser@<ip of ansiblectrl>
```

## Install ansible on ansiblectrl and azure ansible module

Execute following command in order to install ansible and ansible azure module

```bash
yum install -y git
git clone https://github.com/pushpendera/nokia_assignment.git

cd nokia_assignment/azure_resources
chmod +x ansible-install.sh

./ansible-install.sh
```

Login to azure and do initial setup
```bash
az login
```
Follow instruction and complete login process. Now do initial setup as follow

```bash
mkdir ~/.azure
vi ~/.azure/credentials
```

paste following lines

```vi
[default]
subscription_id=<your-subscription_id>
client_id=<security-principal-appid>
secret=<security-principal-password>
tenant=<security-principal-tenant>
```

Now we are ready to create k8server machine.

```bash
cd /root/nokia_assignment/azure_resources
ansible-playbook create_vm_playbook.yml
```

This will print the vm IP. Add it to inventory file
```vi
vi inventory.txt
[kubeserver]
10.0.0.6
```

Now login to kubeserver machine and add kubeuser to sudoers

```bash
ssh -i ~/.ssh/id_rsa.pub kubeuser@10.0.0.6
sudo -i
visudo

Now add a entry in the file as
kubeuser ALL=(ALL) NOPASSWD:ALL

exit
exit
```

Now we can start deploying kubernetes on this. For this we will use ansible playbook to configure k8s on this node.

# Step 2 Configure single node k8s
No since environment is ready

![alt text](https://github.com/pushpendera/nokia_assignment/blob/main/blob/azure%20resource.PNG)

we need to install kubernetes on single machine.




# Step 3 Deploy nginx in k8s
