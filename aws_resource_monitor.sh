#!/bin/bash
#############################
# Author: Jayant Kumar Pathak
# Date : 6th Jan 2026
# Version : v1
####################################################
# This shell script will monitor AWS resource usage
####################################################

# AWS S3
# AWS EC2
# AWS Lambda 
# AWS IAM user

set -x 
# List AWS S3 buckets
echo "List S3 buckets"
aws s3 ls

# List Ec2 Instances
echo "list EC2 Instances"
aws ec2 describe-instances --region us-east-1 | jq '.Reservations[].Instances[].InstanceId'

# List Lambda function
echo "List Lambda function"
aws lambda list-functions | jq '.Functions[].FunctionName'

# List IAM user 
echo "List IAM user"

aws iam list-users | jq '.Users[].UserName'


