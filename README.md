# woabelfast_summer
Primary Project Repo

# Project Requirements

To start development on this project, clone this repo.
- Ensure you have Vagrant installed
- Ensure you have Ansible installed
- Ensure you have VirtualBox installed

Once you have cloned the repo you can start the environment by accessing the directory via terminal and running "vagrant up {server name}" or just "vagrant up" to create them all.

Servers:

- proxy
- wordpress
- db

To connect to each individual machine use "vagrant ssh {server name}"
If making changes to the ansible files, make sure to type "vagrant provision" to check the desired result has been achieved.
See link under 'Training and Resources' to view the ansible structure we have followed.

## Ansible Lint
Firstly, use the workon command to switch to your virtual environment.  Type the following command to install the ansible-lint tool: 

    pip install ansible-lint

On the command line, type ansible-lint and then tab to your site.yml file.  Ansible-lint will check your yaml code for indentation and syntax errors.

# Training and Resources 
https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html


