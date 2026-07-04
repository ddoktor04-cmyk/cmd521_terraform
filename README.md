# AWS Terraform Demo Project

Infrastructure as Code (IaC) project for provisioning AWS EC2 instance with security groups using Terraform.

## Project Structure

```
cmd521_terraform/
├── main.tf                    # Main Terraform configuration
├── vars.tf                    # Variable declarations
├── terraform.tfvars           # Secrets (not in git)
├── terraform.tfvars.example   # Example variables file
├── files/
│   └── script.sh              # User data script for EC2
├── .gitignore                 # Git ignore rules
└── README.md                  # This file
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.15.7
- [AWS Account](https://aws.amazon.com/) with appropriate permissions
- [AWS CLI](https://aws.amazon.com/cli/) configured (optional)

## Quick Start

### 1. Clone the repository

```bash
git clone <repository-url>
cd cmd521_terraform
```

### 2. Configure variables

Copy the example variables file and fill in your AWS credentials:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your values:

```hcl
aws_access_key    = "AKIA..."
aws_secret_key    = "..."
aws_region        = "eu-north-1"
aws_image_id      = "ami-..."
aws_instance_type = "t3.small"
aws_key_name      = "Key1"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the plan

```bash
terraform plan
```

### 5. Apply the configuration

```bash
terraform apply
```

### 6. Destroy resources (when done)

```bash
terraform destroy
```

## Resources Created

| Resource | Description |
|----------|-------------|
| `aws_instance.EC2_instance` | EC2 instance (t3.small) with 20GB gp3 EBS |
| `aws_security_group.SG_Terraform` | Security group for the instance |
| `aws_security_group_rule.ingress_rule` | Ingress rules (SSH, HTTP, ICMP) |
| `aws_security_group_rule.egress_rule` | Egress rule (all outbound) |

## Security Group Rules

| Protocol | Port | Source | Description |
|----------|------|--------|-------------|
| TCP | 22 | 0.0.0.0/0 | SSH access |
| TCP | 80 | 0.0.0.0/0 | HTTP access |
| ICMP | 8 | 0.0.0.0/0 | ICMP Ping access |
| All | All | 0.0.0.0/0 | Outbound traffic |

## User Data Script

The EC2 instance runs a user data script that installs and starts Apache2:

```bash
#!/bin/bash
sudo apt -y update && sudo apt -y install apache2
sudo systemctl start apache2 && sudo systemctl enable apache2
```

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_access_key` | AWS Access Key ID | - |
| `aws_secret_key` | AWS Secret Access Key | - |
| `aws_region` | AWS region | eu-north-1 |
| `aws_zone` | AWS availability zone | eu-north-1a |
| `aws_image_id` | AMI ID for EC2 | ami-0aba19e56f3eaec05 |
| `aws_instance_type` | EC2 instance type | t3.small |
| `aws_key_name` | Name of SSH key pair | Key1 |

## Security

- **Secrets**: Stored in `terraform.tfvars` (not committed to git)
- **Sensitive variables**: Marked with `sensitive = true`
- **Security Group**: Rules for SSH, HTTP, and ICMP access

⚠️ **Important**: Never commit `terraform.tfvars` to version control!

## Environment Configuration

### Dev
- Instance type: t3.small
- EBS: 20GB gp3

### Production (recommended)
- Instance type: t3.medium or larger
- EBS: 20GB+ gp3 with encryption
- Multi-AZ deployment
- Deletion protection enabled

## Cleanup

To destroy all created resources:

```bash
terraform destroy
```

## License

This project is for demonstration purposes.
