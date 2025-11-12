# Terraform Infrastructure Setup

This Terraform configuration automatically provisions the following AWS resources:

## Resources Created

1. **EC2 Instance** - Ubuntu server with Docker installed
2. **S3 Bucket** - For storing Terraform state
3. **DynamoDB Table** - For Terraform state locking
4. **Security Group** - With rules for HTTP, HTTPS, and SSH
5. **IAM Role** - For EC2 instance permissions

## Prerequisites

- AWS Account with appropriate credentials
- Terraform installed (v1.0+)
- AWS CLI configured
- An EC2 Key Pair already created in your AWS account

## Setup Instructions

### 1. Install Terraform

```bash
# On macOS with Homebrew
brew install terraform

# On Linux
wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
unzip terraform_1.5.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

### 2. Configure AWS Credentials

```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Enter your default region (e.g., us-east-1)
```

### 3. Create terraform.tfvars

Create a `terraform.tfvars` file in the terraform directory:

```hcl
aws_region   = "us-east-1"
project_name = "myapp"
instance_type = "t3.medium"
key_pair_name = "your-key-pair-name"  # Replace with your EC2 key pair
allowed_ssh_cidr = ["0.0.0.0/0"]       # Change to your IP for security
```

### 4. Initialize Terraform

```bash
cd terraform
terraform init
```

### 5. Review the Plan

```bash
terraform plan
```

### 6. Apply the Configuration

```bash
terraform apply
```

Type "yes" when prompted to confirm.

## Accessing Your Application

After Terraform completes, you can access your application at:

```
http://<EC2_PUBLIC_IP>
```

The EC2 public IP will be displayed in the Terraform output.

## Output Variables

After successful deployment, Terraform will output:

- `ec2_public_ip` - Public IP address of the EC2 instance
- `ec2_public_dns` - Public DNS name of the EC2 instance
- `s3_bucket_name` - Name of the S3 bucket for state
- `dynamodb_table_name` - Name of the DynamoDB table for locks
- `security_group_id` - Security group ID

## Destroying Resources

To delete all resources:

```bash
terraform destroy
```

## Important Notes

- The EC2 instance will automatically clone the GitHub repository and deploy the Docker application
- SSH access is open to all IPs (0.0.0.0/0) by default - restrict this in `variables.tf` for security
- The application runs on port 80
- Docker and Docker Compose are automatically installed on the instance

## Troubleshooting

### SSH into EC2 Instance

```bash
ssh -i your-key.pem ubuntu@<EC2_PUBLIC_IP>
```

### Check deployment status

```bash
cat /home/ubuntu/deploy_status.txt
```

### View Docker container logs

```bash
sudo docker logs myapp
```
