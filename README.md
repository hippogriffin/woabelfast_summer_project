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

After cloning the repo run the following commands

```
pre-commit autoupdate
```

```
pre-commit install
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
## sshd
OpenSSH SSH deamon configuration

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

## Installing Nginx

The nginx role from ansible galaxy was installed using the following command:
    
    ansible-galaxy install geerlingguy.nginx -p roles

Inside site.yml,  the role was applied to the webservers group which contains the proxy VM

## mysql 

We installed a MySQL role from ansible galaxy: 
https://galaxy.ansible.com/geerlingguy/mysql

This role installs and configures MySQL or MariaDB server on RHEL/CentOS or Debian/Ubuntu servers.

This role was then included in the requirements.yml file to be installed on the db servers. All of the roles that appear in this file can be installed using...

    ansible-galaxy install -r requirements.yml -p roles_galaxy

We then built on this role by updating the db_servers.yml file within the group_vars folder to create users, set the admin password, and create a Database. 

When we ssh onto the db server we can log on as MySQL root user using: 

    mysql -u root -p

We can then check our users or databases by using one of the following commands...

    SELECT User, Host, Password FROM mysql.user;
or
    
     SHOW DATABASES; 

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

# Define sysctl configuration in Ansible

Ansible already has pre-configured modules for editing sysctl files. However because this is for training purposes to gain a better understanding a custom template has been made.

This would also be used in a real project when you are requiring different configurations for groups and machines.

To add anything to sysctl just add it below <b>sysctl:</b>

Example:

```
 sysctl:
  net.ipv4.ip_forward: 1
  add.your.line.here:value
```

# singleplatform-eng.users

This role is for managing users on our system. 

Downloaded from: https://galaxy.ansible.com/singleplatform-eng/users
  
    ansible-galaxy install singleplatform-eng.users

Once included in the site.yml file, an all.yml file was created within the group_vars folder to add all of the users. In this file a group was created called 'webops_admins' where the users would be assigned. The users relevant data is declared here including their ssh keys, uid, and the groups they are a part of. 



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

# Configuring Firewalls

Firewalls are configured using the Ansible role geerlingguy.firewall

This can be configured using group_vars.

Configurable variables can be found in:
roles_galaxy/geerlingguy.firewall/defaults/main.yml

### Example
    firewall_allowed_tcp_port:
      - "22"
      - "80"


# Adding Yum Repositories

Yum repositories can be adde using the yum_repos role.

These are created using the variable yum_repo_files wihch can be configured in vars.

### Example
    yum_repo_files:
      - name: nginx
        description: nginx repo
        baseurl: http://nginx.org/packages/centos/$release/$basearch/
        enabled: yes
        state: present

Additional repositories can be added with a new list.

This will create a repo file for nginx. A populated example can be found in defaults/main.yml

# Training and Resources 
https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html

