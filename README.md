# Mozilla SOPS demonstration with AWS S3 and KMS

## Overview
SOPS helps to overcome challenges of managing secrets / credentials securely together with giops operations. You can find more details about SOPS [here](https://github.com/mozilla/sops#extract-a-sub-part-of-a-document-tree). In this example, I will showcase these features
- Create AWS S3 bucket using Terraform 
- Create IAM policy to grant read / write access to S3 bucket
- Create KMS key service using Terraform
- Create IAM policy to grant encrypt / decrypt access with KMS
- SOPs yaml files with rules to encrypt files and upload to S3


## Infrastructure
If you would like to test the setup, here are the steps you should follow.
1. Clone the repository
2. Ensure AWS CLI is installed in you computer and access credemtials are set
3. Ensure region env variable is set `export AWS_REGION=us-west-2`
4. Run terraform commands to deploy the infra
'''I am using existing IAM user for this example. Use existing IAM user in your account or create new one.
- These are the terraform files included
'''`main.tf` file creates S3 bucket, IAM policy for S3 access
'''`kms.tf` file create KMS key and IAM policy for encrypt/decrypt 
'''`variables.tf` variables defined here
5. Install SOPS in your computer / server
6. Once infra is successfully deployed you are ready to test the SOS


## Test SOPS
- SOPS rules are defined inside `.sops.yaml` file
- Creation rule indicates that all the files created inside s3 folder are encrypted using KMS key
- Destinatino rule indicates thata files inside s3 folders can be pushed to a S3 bucket specified bucket
- Update the ARN values inside `.sops.yaml` for S3 and KMS according to your environment

## Commands
Create credential file. This will create the specified file with encrypted passwords (abc123 in this case) inside the document
```
sops s3/mysql-password.yaml
passwd: abc123
```
Upload the file to S3 bucket
```
sops publish s3/mysql-password.yaml
```
