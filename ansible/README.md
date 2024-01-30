# Ansible Playbook for instance configuration and ressources installation

## Resume
> For the Ansible installation architecture i proceed with simple sub-playbooks for each instance to remove complexity of using roles 

The ansible project is organize as follow
- the `/playbooks`folder contains the dedicated playbooks for installations on each instance (jenkins_server, monitoring_server, etc...)
- the `/host_vars` folder contains the variable used on each instance for specific use case
- the `/files` folder contains comon file or configuration that could be used during any of the playbook

then a the root level you have the `main-playbook.yml` which include ready to used playbook fo te installation and configuration

# Notes
Before running the main playbook file of any of the playbook, please be sure to update all the variables used fo the installation
- `inventory.ini` host ip address variabales
- each variables file in `host_vars` folder
- take time to go trought all to identify how each variable is used


## References
- [Ansible documentation](https://docs.ansible.com/)
