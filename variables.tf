variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "iam_role_name" {
  description = "Name of the IAM role to be created for GitHub Actions"
  type        = string
  default     = "github-actions-oidc-role"
}

variable "allowed_repository_strings" {
  description = "List of GitHub repository patterns allowed to assume the role"
  type        = list(string)
}

variable "policy_arns" {
  description = "List of IAM Policy ARNs to attach to the role"
  type        = list(string)

}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    ManagedBy = "terraform"
  }
}
