#!/bin/bash
# Fills an array with ec2 instance ids, that have the tag 'preview'
# Then shuts each of the instances down using the id's

my_array=()

# populate the array with preview ec2 instance ids 
while IFS= read -r line; do
    my_array+=( "$line" )
done < <( aws ec2 describe-instances --filters "Name=tag:Environment,Values=preview" --query 'Reservations[*].Instances[*].InstanceId' --output text )


# print contents of array
# printf '%s\n' "${my_array[@]}"

# print arrays length 
# i=${#my_array[@]}
# echo $i


# loop through array and shutdown the instances 
for i in "${my_array[@]}"
do
    aws ec2 stop-instances --instance-ids $i
done