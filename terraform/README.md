# woabelfast_summer
Primary Project Repo

## Terraform commands

### Terraform Init

Run terraform init to initiate terraform

### Terraform Plan

Run terraform plan to preview proposed changes

### Terraform Apply

Run terraform apply to apply proposed changes when the changes have been merged into master.

## All environments

SSH public key was added to all instances to allow SSH access for all users. 

This key was initially an ED25519 key but this is not compatible with Jenkins so has been reverted back to RSA. Both public ssh keys are present in user_data attribute inside instance.tf for each environment.

The lifecycle parameter was added to all instance.tf files to prevent the instances from being destroyed during a terraform apply.

## DMZ

Resources that will be created in terraform apply:

- ec2 instance
- vpc
- security group
- subnet
- private dns zone

## Management

Resources that will be created in terraform apply:

- ec2 instance
- vpc
- security group
- subnet
- private dns zone
- internet gateway
- nat gateway
- elastic ip for nat gateway
- aws route table for internet gateway
- aws route table for nat gateway

Deployment user created for Jenkins. Private key added to Jenkins to enable running of ansible jobs against environments.

### Management security group

Allows SSH traffic from dmz subnet to management subnet

## Preview

### Added Security group for DB

- Currently no config added please address
- Dummy ingress in place for now to allow terraform to build

### Added Subnet for DB
- No real config as of yet

# Azure 

## Adding Security Group

### DMZ 
Allows SSH connection from Kainos IP. 
 
### Preview
Allow SSH and open port 3306 for MySQL