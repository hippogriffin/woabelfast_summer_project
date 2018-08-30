# woabelfast_summer
Primary Project Repo

# Project Requirements

To start development on this project clone this repo.
- Ensure you have VirtualBox installed
- Ensure you have Vagrant installed
- Ensure you have Ansible installed
- Ensure you have Ansible Lint installed

Once you have cloned the repo you can start the environment by accessing the directory via terminal and running "vagrant up {server name}" or just "vagrant up" to create them all.

Servers:
db
proxy
wordpress

To connect to each individual machine use "vagrant ssh {server name}"
If making changes to the ansible files, make sure to type "vagrant provision" to check the desired result has been achieved.
See link under 'Training and Resources' to view the ansible structure we have followed.


## Ansible Lint
Firstly, use the workon command to switch to your virtual environment.  Type the following command to install the ansible-lint tool: 

    pip install ansible-lint

On the command line, type ansible-lint and then tab to your site.yml file.  Ansible-lint will check your yaml code for indentation and syntax errors.

# Git Setup

After cloning the repo find a folder called scripts

Pre-hooks

find a file called "pre-commit" move this file to your .git/hooks folder
run the following command:  

```
chmod +x .git/hooks/pre-commit
```

# Training and Resources 
https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html


# Ansible Roles 

This role manages the SSH configuration on our servers and was downloaded from ansible-galaxy... https://galaxy.ansible.com/willshersystems/sshd

By default it configures the SSH daemon with the normal OS defaults. It...

- Works across a variety of UNIX like distributions
- Can be configured by dict or simple variables
- Supports Match sets
- Supports all sshd_config options. 
- Tests the sshd_config before reloading sshd.

This role is added to the project through including it in the site.yml file, under the roles heading. 


# Sudoer Groups using Ansible 

A sudo user stand for Super User Do. 

When you run the sudo command it will 
- Ask you for your password 

- Then check the sudoers file to see what privileges you have 

The System Admin / Root user can change the configuration file for different groups and different users giving everyone suitable access they may be able to run full commands like root or they may only have access to a small amount of commands.

We will be changing the sudoer groups using 
```
base_sudoer_groups:
```

This can be edited in
```
roles/common/defaults/main.yml
```


