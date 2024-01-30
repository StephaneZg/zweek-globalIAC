# AWS Infrastructure Provisioning with Terraform

## Summary
We utilize Terraform to streamline the creation and destruction of infrastructure. By leveraging Terraform, we can easily manage resources, saving costs when the infrastructure is not in use and rapidly deploying it when needed.

Our infrastructure is solely provisioned on AWS and integrates a secure **S3 Backend** to safeguard sensitive information and prevent inadvertent exposure in the Git repository.

### Terraform Project Structure
- `vpc.tf`: Configures the VPC and related resources (subnets, internet gateway, route tables, etc.).
- `networking.tf`: Establishes network security configurations for the instances.
- `dns.tf`: Manages DNS record configurations (can be commented out if not required).
- `compute.tf`: Handles the provisioning of instances for this project.
- `output.tf`: Provides essential information such as **Public and Private IPv4 addresses** for subsequent steps in the Ansible phase.

## Notes
Before executing the main playbook file or any playbook, ensure all variables used for the installation are updated:
- Review and update variables defined in `variables.tf`.

## References
- [Terraform Registry](https://registry.terraform.io/)
