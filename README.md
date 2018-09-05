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
Ensure you are running your virtual enviroment (Using Virtual Wrapper before following these steps)

After cloning the repo run the following commands

```
sudo -H pip install pre-commit
```

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

## yum_packages
This role has two main tasks within it, one for installing common yum packages across all servers, and one for installing custom yum packages across specific servers. 

To install a yum package on all hosts, go to group_vars/all.yml and include the package name under 'common yum installs'. 

To install a yum package on a specific host, go to group_vars/"group name".yml and include the package name under 'custom yum installs'. 

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

## Configuring Firewalls

Firewalls are configured using the Ansible role geerlingguy.firewall

This can be configured using group_vars.

Configurable variables can be found in:
roles_galaxy/geerlingguy.firewall/defaults/main.yml

### Example
    firewall_allowed_tcp_port:
      - "22"
      - "80"


## Adding Yum Repositories

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

# Creating VPC Resources
Under Environments & within dmz, management & preview folders, add the following to the vpc.tf file of each, making changes where appropriate:

### Example
    # Preview VPC 
    resource "aws_vpc" "preview_vpc" {
        cidr_block = "10.122.0.0/24"

        enable_dns_support = true
        enable_dns_hostnames = true

        tags {
	        Name = "${var.environment}"
        }
    }

Add the following to the variables.tf file of each Environment:

### Example

    variable "environment" {
    default = "dmz"
    }
    
# Terraform

# DMZ


## Internet Gateway

An Internet Gateway has been created for the DMZ environment

## DMZ Subnet

The DMZ subnet cidr has been defined in the variables.tf file in the DMZ folder. Additional jumpboxes must be added to this subnet. 

## DMZ Security Group

This Security group allows traffic from Kainos to the jumpbox.

Additional inbound rules can be added by including new ingress rules in securitygroups.tf

This group should be applied to all jumpboxes.

## DMZ Key Pair

The public key to be used for all hosts in the DMZ environment is found in keypair.tf.  

## Private DNS 

Hosted zone created for enviroment.woabelfast.local all code can be found in main.tf for each enviroment using a vpc we can traffic information between the devices.


# Management

## Management Instances

Management instances are configured in the management/instance.tf file

Variables for these instances are stored in the management/variables.tf file

All instances should be added to the management subnet

# Preview

## Wordpress Subnet

The subnet for the wordpress server in the preview environment is called preview_wordpress.  The default CIDR block for this subnet is specified within preview/variables.tf

## Wordpress Security Group

This security group allows ssh traffic from the dmz subnet and allows web traffic from the proxy subnet.

Additional inbound rules can be added by including new ingress rules in securitygroups.tf

This group should be applied to all wordpress servers.

## RDS Preview

Provides an RDS instance resource. Created a rds.tf file as below.
- In securitygroups.tf duplicate the security group & rename as backup.
- In subnets.tf duplicate the subnet group & rename as backup, adding an availability zone to both.

### Example

    resource "aws_db_instance" "preview_rds" {
        allocated_storage      = 10
        storage_type           = "gp2"
        engine                 = "mysql"
        engine_version         = "5.7"
        instance_class         = "db.t2.micro"
        name                   = "${var.preview_rds}"
        username               = "wpuser"
        password               = "12345"
        parameter_group_name   = "default.mysql5.7"
        db_subnet_group_name   = "${aws_db_subnet_group.preview_rds_subnet_group.id}" 
        vpc_security_group_ids = ["${aws_security_group.wp_servers.id}"]
        }

        resource "aws_db_subnet_group" "preview_rds_subnet_group" {
        name       = "main"
        subnet_ids = ["${aws_subnet.preview_db_subnet.id}", "${aws_subnet.preview_db_subnet_backup.id}"]

        tags {
            Name = "RDS Subnet Group"
            }
        }

## DMZ Key Pair

The public key to be used for all hosts in the DMZ environment is found in keypair.tf.  

## Wordpress Instance

Wordpress instances are configured in the */instance.tf file

Variables for these instances are stored in the */variables.tf file

All instances should be added to the *_wordpress subnet

.* = environment (preview/preprod/production)

To add more servers, edit the variables.tf file and add a new line to the wp_server_ips variable and the wp_server_host_name local

Example

    variable "wp_servers_ips" {
        default {
            "0" = "10.122.2.10"
            "1" = "10.122.2.11"
            --------------
            "2" = "10.122.2.12"
        }
    }
.

    locals {
        wp_server_host_name { 
        "0" = "${var.environment}_${var.wp_server_name}_01"
        "1" = "${var.environment}_${var.wp_server_name}_02"
        ------------------------
        "2" = "${var.environment}_${var.wp_server_name}_03"
        }
    }

## VPC Peering

There is a VPC peering connection between Preview and Management. This has been configured using vpc_peering.tf.

In order for this to work, Management __MUST__ be applied first.

The VPC_ID of the Management environment comes from the Management remote state file. This has been configured using terraform_remote_state

First, take an output of the VPC ID from Management

    ### __IN MANAGEMENT__
    output "mgmt_vpc_id" {
        value = "${aws_vpc.mgmt_vpc.id}"
    }

The next time a terraform apply is ran on the Management environment, this output will be stored in the remote state file.

Now, Preview must be configured to load Management's remote state.

    ### __IN PREVIEW__
    data "terraform_remote_state" "woa-belfast-mgmt" {
    backend = "s3"
    config {
        bucket = "woa-belfast"
        key = "management/woa.tfstate"
        region = "eu-west-1"
        }
    }

You can now use data.terraform_remote_state.woa-belfast-mgmt.mgmt_vpc_id to get the VPC ID from the Management environment

    ### __IN VPC_PEERING CONFIG__
    peer_vpc_id = "${data.terraform_remote_state.woa-belfast-mgmt.mgmt_vpc_id}"

# Training and Resources 
https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html

https://www.terraform.io/docs