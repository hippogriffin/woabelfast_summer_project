#!/bin/bash
# Script used for shutting down any virtual machines in the specified environment
# When running this script make sure to pass the environment parameter - e.g. 'preview', 'preproduction'

####################################################
# AWS first 

aws_array=()

# populate the array with ec2 instance ids 
while IFS= read -r line; do
    aws_array+=( "$line" )
done < <( aws ec2 describe-instances --filters "Name=tag:Environment,Values=$1" --query 'Reservations[*].Instances[*].InstanceId' --output text )


# loop through array and shutdown the instances 
for i in "${aws_array[@]}"
do
    aws ec2 stop-instances --instance-ids $i
done


######################################################
# Azure equivalent 

azure_array=()

# populate the array with the virtual machine names 
while IFS= read -r line; do
    azure_array+=( "$line" )
done < <( az resource list --resource-group $1_rg --resource-type Microsoft.Compute/virtualMachines --query "[].[name]" -o tsv )

# loop through array and shutdown the vms 
for i in "${azure_array[@]}"
do
    az vm stop --resource-group $1_rg --name $i
    echo Azure instance shutdown...
    echo $i
done