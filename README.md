# ZWeeek Challenge week 2 : Global infra IAC with Terraform & Ansible

## Table of Contents
- [Resume](#resume)
- [Installation](#installation)
- [Conclusion](#Conclusion)

<img title="Provisionned instances" alt="Ec2 instances provisionned" src="./assets/images/instances.png">

## Resume
> In other to be able to rapidly provision our infra and get ready for each week update, it was really a need for an IAC configuration, in that case the tools we used are **Terraform & Ansible**. the seperation is made on the root directory based on those two folders [Ansible](./ansible/README.md) and [Terraform](./terraform/README.md)

## Installation

Before proceeding on this project configuration, make sure to install various tools, mainly :
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

**Create and configure your CLI Access locally (Secret Key and Access Key)**

And for a great experience woking with each file depending on the IDE your are using **VS Code, IntellIJ IDEA etc...**, look for existing extension or plugins

### Installations Steps
#### Step 0 : Add AWS CLI access Env Variables
Refer to the provider documentation for that [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables) 

#### Step 1 : Update all variables
Update all needed environment and project variables and informations needed by the configuration to run properly, refer to each project directory : [Ansible](./ansible/README.md) and [Terraform](./terraform/README.md)

#### Step 2 : Deploy Infra with Terraform
- Head to the [`/terraform`](./terraform/README.md) directory and if the [Step 1](#steps-1--update-all-variables) was done properlly, run these commands 
    - `terraform plan` to view ressources which are going to be provisionned in your account
    - `terraform apply` to apply those configurations

> When everything is okay and well provisionned check the output information where you have **Private and Public Ip** address of provisionned Ec2 instances

#### step 3 : Configure All Server with Ansible
- Head to the [`/ansible`](./ansible/README.md) directory and if [Step 1](#Steps-1--update-all-variables) and [step 2](#Steps-2--deploy-infra-with-terraform) were done properlly, run these commands
    - First fill all the output information in dedicated files
        - Private IP on each host-vars file
        - Public Ip on each instance *ansible_host* variable
    - `ansible-playbook -i inventory.ini main-playbook.yml`

## Conclusion
> Make sure to shut down all the ressources when you are done with the infra to prevent unecessary cost on your account

<img title="Provisionned instances" alt="Ec2 instances provisionned" src="./assets/images/instances.png">

<img title="Provisionned Security Group" alt="Security Groups provisionned" src="./assets/images/security-group.png">

<img title="DNS Record" alt="DNS record" src="./assets/images/dns.png">