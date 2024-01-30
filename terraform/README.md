# AWS infrasructure provisionning with Terraform

## Resume
> We Used Terrafom here to facilitate the creation and destroy of the infrastructure, which base on the provisionned ressource help we save cost when the infra not used and set it upda rapidlly when need

Considering our use cae the only provider used is **AWS** coopled with and **S3 Backend** to protect sensitive information and prevent pushing them to te git repo 

The terraform project structure is as follow
- The `vpc.tf` file is used to contain the configuration for the VPC and related resources provisiotioning such as (subnet, internet gateway, route table, etc....)
- The `networking.tf` file is used for network security configuration over the instance tha will be used
- The `dns.tf` file will contains all dns record configuration (in the case you don't want to used dns for your infra you can just comment everything in this file)
- The `compute.tf` file is all about the instance we are going to provision in this challenge
- The `outout.tf` file contain all needed information **Public and Private Ipv4 address** used for the next steps on ansible part

# Notes
Before running the main playbook file of any of the playbook, please be sure to update all the variables used fo the installation
- `variables.tf` all used variables in the configuraton

## References
- [Terraform Registy](https://registry.terraform.io/)