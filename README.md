# ECS Enterprise - IaC - VPC
This infrastructure defines a VPC architecture for an AWS ECS cluster using a custom Terraform VPC module.

The architecture aims to deploy a hybrid multi-AZ infrastructure with NAT, and Internet Gateways.

It consists of deploying four subnets, two private and two public, with 3 security groups for the application tiers and load balancer.

The VPC resources are exposed through output blocks and retrieved using remote state data resources so other resources can use it.

# GitOps Workflow

This module integrates with GitHub Actions workflow using OpenID Connect (OIDC) to authenticate with AWS. The workflow:

1. Clones the source repository.
2. Retrieves the updated Terraform module.
3. Plans and applies the deployment per environment with state file per each.

# Prerequisites

1. Terraform
2. Configured AWS CLI
3. Private S3 bucket with PutObject and GetObject permissions to store Terraform states.

# How to Use Template

1. Clone the main branch.
2. Configure `environments/ENVIRONMENT/backend.tfvars` to connect to the S3 bucket per environment.
3. Configure `environments/ENVIRONMENT/variables.tfvars`.tfvars with the required environment variables.
4. By default, only production and staging environments are created. The development environment uses the staging state for verification; resources are not deployed, only validated by the workflow.

# How to Deploy:
```
terraform init -backend-file "environments/ENV/backend.tfvars" -var-file="../environments/Base/variables.tfvars"

terraform plan -var-file "environments/ENV/ENV.tfvars" -out=tfplan

terraform apply "tfplan"
```

For further configuration, refer to the VPC module.