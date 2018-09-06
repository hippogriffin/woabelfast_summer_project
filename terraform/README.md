# woabelfast_summer
Primary Project Repo

## Terraform commands

### Terraform Init

Run terraform init to initiate terraform

### Terraform Plan

Run terraform plan to preview proposed changes

### Terraform Apply

Run terraform apply to apply proposed changes when the changes have been merged into master.

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

### Management security group

Allows SSH traffic from dmz subnet to management subnet

## Preview

### Added Security group for DB

- Currently no config added please address
- Dummy ingress in place for now to allow terraform to build

### Added Subnet for DB
- No real config as of yet