#!/bin/bash
# Script used for starting up and virtual machines in the Preview environment

###########################################
# AWS first 

aws_array=()

# populate the array with preview ec2 instance ids 
while IFS= read -r line; do
    aws_array+=( "$line" )
done < <( aws ec2 describe-instances --filters "Name=tag:Environment,Values=preview" --query 'Reservations[*].Instances[*].InstanceId' --output text )


# loop through array and start-up the instances 
for i in "${aws_array[@]}"
do
    aws ec2 start-instances --instance-ids $i
done


############################################
# Azure equivalent 

azure_array=()

# populate the array with preview ec2 instance ids 
while IFS= read -r line; do
    azure_array+=( "$line" )
done < <( az resource list --resource-group preview_rg --resource-type Microsoft.Compute/virtualMachines --query "[].[name]" -o tsv )

# loop through array and start-up the instances 
for i in "${azure_array[@]}"
do
    az vm start --resource-group preview_rg --name $i
done