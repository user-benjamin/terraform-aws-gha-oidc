# terraform-aws-gha-oidc

Terraform configuration for setting up GitHub Actions OIDC authentication with AWS.

## Overview

This Terraform configuration creates the necessary AWS IAM resources to enable GitHub Actions workflows to authenticate with AWS using OpenID Connect (OIDC). This approach eliminates the need for storing long-lived AWS credentials as GitHub secrets.

## What it creates

- An AWS IAM OIDC provider for GitHub Actions
- An IAM role with a trust relationship to the OIDC provider
- Policy attachments to grant permissions to the role

## Usage

1. Clone this repository
2. Adjust `terraform.tfvars` if needed (it's configured for HeroesOTCrown org)
3. Initialize and apply the Terraform configuration:

```bash
terraform init
terraform plan
terraform apply
```

4. After applying, note the role ARN from the output:

```
github_actions_role_arn = "arn:aws:iam::123456789012:role/gha-oidc-role"
```

5. Add this role ARN as a secret in your GitHub repository:
   - Secret name: `AWS_ROLE_ARN`
   - Secret value: The ARN from the output

## GitHub Actions Workflow Example

After deploying this configuration, use the following GitHub Actions workflow to authenticate with AWS:

```yaml
name: AWS Deployment with OIDC

on:
  push:
    branches: [ main ]
  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# These permissions are needed for OIDC with AWS
permissions:
  id-token: write  # Required for OIDC
  contents: read   # Required to checkout the repository

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: us-east-1
      
      - name: Verify AWS access
        run: |
          aws sts get-caller-identity
```

## Configuration Details

The current configuration allows:
- GitHub Actions from all repositories in the HeroesOTCrown organization
- Administrator access to AWS

You can modify `terraform.tfvars` to adjust:
- Which GitHub repositories can assume the role
- What permissions the role has
- Tags applied to AWS resources


## License

MIT
