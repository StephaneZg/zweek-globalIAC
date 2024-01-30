# ZWeeek Challenge week 2 : Global infra IAC with Terraform & Ansible

## Table of Contents
- [Resume](#resume)
- [Installation](#installation)
- [Usage](#usage)
- [Conclusion](#Conclusion)

<img title="Provisionned instances" alt="Ec2 instances provisionned" src="./assets/images/instances.png">

## Resume
> In other to been able to rapidlly provision our infra and get ready for each week update, it was really e need for an IAC configuration, i that case the tools we used are **Terraform & Ansible**. the seperation is made on the root directory base on those two folder [Ansible](./ansible/README.md) and [Terraform](./terraform/README.md)

## Installation

Before proceeding on the this confiuration project, make sure to install main tools use :
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- **Create and configure your CLI Access locally (Secret Key and Access Key)**

and for a great experience woking ith each file depending on the IDE your are using **VS Code, IntellIJ IDEA etc...**, looks for existing extension or plugins

### Installations Steps
#### step 0 : Add AWS cli access Env Variables
refer to the provider documentation for that [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables) 

#### step 1 : Update all variables
update all needed variables and information needed by te configuration to run properly

#### step 2 : Deploy Infra with Terraform
- head to the [`/terraform`](./terraform/README.md) directory and if the [step 1](#steps-1--update-all-variables) was done properlly, run these commands 
    - `terraform plan` to view ressources which going to be provisionned in your account
    - `terraform apply` to apply those configurations

> When everythins okay and well provisionned check the outpu information wher you have **Private and Public Ip** address of provisionned Ec2 instances

#### step 3 : Configure All Server with Ansible
- head to the [`/ansible`](./ansible/README.md) directory and if [step 1](#steps-1--update-all-variables) and [step 2](#steps-2--deploy-infra-with-terraform) were done properlly, run these command
    - First fill all the output information in dedicated files
        - Private IP on each host-vars file
        - Public Ip on each instance *ansible_host* variable
    - `ansible-playbook -i inventory.ini main-playbook.yml`

## Conclusion
> Make sure to shut down all the ressource when you are done with the infra to prevent unessery cost on your accout

<img title="Provisionned instances" alt="Ec2 instances provisionned" src="./assets/images/instances.png">

<img title="Provisionned Security Group" alt="Security Groups provisionned" src="./assets/images/security-group.png">

<img title="DNS Record" alt="DNS record" src="./assets/images/dns.png">