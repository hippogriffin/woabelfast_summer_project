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


# Ansible Roles 

To install Ansible Roles make sure you include them in the requirements.yml file.
Each role will consist of one or more of the following:
- src
- version
- name
- scm

 please find an example below

```
# from galaxy
- src: willshersystems.sshd
  version: v0.6.2

# Or to bring in a role from github
- src: https://github.com/bennojoy/nginx
  version: master
  name: nginx_role
```

## willshersystems.sshd

This role manages the SSH configuration on our servers and was downloaded from ansible-galaxy... https://galaxy.ansible.com/willshersystems/sshd

By default it configures the SSH daemon with the normal OS defaults. It...

- Works across a variety of UNIX like distributions
- Can be configured by dict or simple variables
- Supports Match sets
- Supports all sshd_config options. 
- Tests the sshd_config before reloading sshd.

This role is added to the project through including it in the site.yml file, under the roles heading. 
## Common 

### Sudoer Groups using Ansible 

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

## singleplatform-eng.users

This role is for managing users on our system. 

Downloaded from: https://galaxy.ansible.com/singleplatform-eng/users
  
    ansible-galaxy install singleplatform-eng.users

Once included in the site.yml file, an all.yml file was created within the group_vars folder to add all of the users. In this file a group was created called 'webops_admins' where the users would be assigned. The users relevant data is declared here including their ssh keys, uid, and the groups they are a part of. 


# Installing Nginx

The nginx role from ansible galaxy was installed using the following command:
    
    ansible-galaxy install geerlingguy.nginx -p roles

Inside site.yml,  the role was applied to the webservers group which contains the proxy VM

# Encryption

The main tool we can use to encrypt ansible variables is ansible-vault.  This can encrypt any structured data files used by Ansible.

If you want to create a new encrypted file, the command is:  ansible-vault create <filename>

The user will then be prompted to enter a vault password which for our testing we set to: P@55word

We typed the following command to move this password to its own file:

	echo "P@55word" > vault_password
	
(ensure you're in the correct directory)

To encrypt a particular string, we can type:
	
	ansible-vault encrypt_string <name_of_string> --ask-vault-pass

We then used the yq parser for yml files.  This allows us decrypt.  Install using the following command:
	
    brew install yq

There doesn't seem to be any easy way to decrypt a variable in a list, however when we moved the variable out of the list, the decryption worked using the following command

    yq read <target_file_path> filename | ansible-vault --vault-password-file=<password_file_name> decrypt

# Training and Resources 
https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html

