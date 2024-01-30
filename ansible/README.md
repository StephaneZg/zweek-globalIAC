# Ansible Playbook for Instance Configuration and Resource Installation

## Summary
In our Ansible installation architecture, we've simplified complexity by employing dedicated sub-playbooks for each instance. This approach enhances manageability and clarity during configuration.

### Project Organization
- `/playbooks`: Contains dedicated playbooks for installations on each instance (e.g., jenkins_server, monitoring_server, etc.).
- `/host_vars`: Stores variables used on each instance for specific use cases.
- `/files`: Houses common files or configurations that could be utilized during any playbook execution.

At the root level, you'll find `main-playbook.yml`, which integrates ready-to-use playbooks for installation and configuration.

## Notes
Before executing the main playbook or any sub-playbook, ensure all variables used for the installation are updated:
- Update IP address variables in `inventory.ini`.
- Review and update variables in each file within the `host_vars` folder.
- Take the time to understand how each variable is utilized across the playbooks.

## References
- [Ansible Documentation](https://docs.ansible.com/)
