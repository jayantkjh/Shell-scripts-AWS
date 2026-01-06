# Shell-scripts-AWS

## Description
This shell script monitors AWS resources including S3 buckets, EC2 instances, Lambda functions, and IAM users.

## Features
- **S3 Buckets**: Display bucket size and object count
- **EC2 Instances**: Show instance ID, running status, and instance type
- **Lambda Functions**: List function names and programming languages/runtimes
- **IAM Users**: Display user names and creation dates
- **Output**: All results are printed to console and saved to log files with timestamps

## Usage
```bash
bash aws_resource_monitor.sh
```

## Output Logs
Reports are saved to: `/var/log/aws_monitor/aws_resource_report_YYYYMMDD_HHMMSS.txt`

## Cron Job Setup
To run this script automatically:

### Daily at 9 AM and 6 PM
Add the following to your crontab:
```bash
crontab -e
```

Then add these two lines:
```
0 9 * * * /home/Shell-scripts-AWS/aws_resource_monitor.sh
0 18 * * * /home/Shell-scripts-AWS/aws_resource_monitor.sh
```

**Cron Explanation:**
- `0 9 * * *` - Run at 9:00 AM every day
- `0 18 * * *` - Run at 6:00 PM every day

### View Current Cron Jobs
```bash
crontab -l
```

### Remove Cron Jobs
```bash
crontab -r
```

## Requirements
- AWS CLI configured with appropriate credentials
- jq (JSON processor)
- Bash shell

## Notes
- Requires proper AWS IAM permissions to list S3, EC2, Lambda, and IAM resources
- May need sudo privileges to write to `/var/log/` directory