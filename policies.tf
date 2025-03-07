# Optional: Create a custom IAM policy for GitHub Actions
# Uncomment and modify as needed

/*
resource "aws_iam_policy" "github_actions_custom_policy" {
  name        = "github-actions-deployment-policy"
  description = "Custom policy for GitHub Actions deployments"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::your-deployment-bucket",
          "arn:aws:s3:::your-deployment-bucket/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "cloudfront:CreateInvalidation",
          "cloudfront:GetInvalidation",
          "cloudfront:ListInvalidations"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource = "arn:aws:ecr:*:*:repository/your-ecr-repo"
      }
    ]
  })
}

# To use this custom policy, add its ARN to the policy_arns variable in terraform.tfvars:
# policy_arns = [
#   aws_iam_policy.github_actions_custom_policy.arn
# ]
*/
