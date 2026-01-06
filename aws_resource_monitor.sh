#!/bin/bash
#############################
# Author: Jayant Kumar Pathak
# Date : 6th Jan 2026
# Version : v4
####################################################
# This shell script will monitor AWS resource usage
####################################################

# AWS S3
# AWS EC2
# AWS Lambda 
# AWS IAM user

set -x
set -e
set -o pipefail

# Create logs directory if it doesn't exist
LOG_DIR="/var/log/aws_monitor"
mkdir -p "$LOG_DIR"

# Set output file with timestamp
OUTPUT_FILE="$LOG_DIR/aws_resource_report_$(date +%Y%m%d_%H%M%S).txt"

{
echo "=================================================="
echo "AWS RESOURCE MONITORING DASHBOARD"
echo "=================================================="
echo ""

# List AWS S3 buckets with size and object count
echo "========== S3 BUCKETS =========="
echo ""
aws s3api list-buckets --output json | jq -r '.Buckets[] | .Name' | while read bucket; do
    aws s3api list-objects-v2 --bucket "$bucket" --output json | jq -r --arg bucket "$bucket" '
        (.Contents | map(.Size) | add // 0) as $size |
        (.Contents | length) as $count |
        "Bucket: \($bucket) | Size: \($size/1024/1024 | floor) MB | Objects: \($count)"
    '
done
echo ""

# List EC2 Instances with status and instance type
echo "========== EC2 INSTANCES =========="
echo ""
aws ec2 describe-instances --region us-east-1 --output json | jq -r '.Reservations[].Instances[] | "Instance ID: \(.InstanceId) | Status: \(.State.Name) | Type: \(.InstanceType)"'
echo ""

# List Lambda functions with runtime/language
echo "========== LAMBDA FUNCTIONS =========="
echo ""
aws lambda list-functions --region us-east-1 --output json | jq -r '.Functions[] | "Function Name: \(.FunctionName) | Runtime: \(.Runtime)"'
echo ""

# List IAM users with last access time
echo "========== IAM USERS =========="
echo ""
aws iam list-users --output json | jq -r '.Users[] | "User: \(.UserName) | Created: \(.CreateDate)"'
echo ""
echo "=================================================="
echo "END OF REPORT"
echo "=================================================="
} | tee "$OUTPUT_FILE"

echo ""
echo "Report saved to: $OUTPUT_FILE"