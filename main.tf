resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  tags            = var.tags
}

resource "aws_iam_role" "github_actions" {
  name               = "gha-oidc-role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role_policy.json
  description        = "IAM Role for GitHub Actions OIDC"
  tags               = var.tags
}

data "aws_iam_policy_document" "github_actions_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.allowed_repository_strings
    }
  }
}

resource "aws_iam_role_policy_attachment" "github_actions_policy_attachment" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.github_actions.name
  policy_arn = var.policy_arns[count.index]
}
