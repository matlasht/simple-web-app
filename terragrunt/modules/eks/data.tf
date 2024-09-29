data "aws_eks_cluster" "cluster" {
  name = module.eks.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.eks_cluster_id
}

data "external" "aws-auth" {
  program = ["bash", "../../scripts/aws_auth.sh"]
  # query = {
  #   account_id = var.account_id
  # }
}


data "aws_iam_policy_document" "inline_policy" {
  statement {
    actions   = [
      "elasticache:DescribeReplicationGroups",
      "route53:ListHostedZones",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:DescribeImages",
      "eks:DescribeCluster",
      "eks:UpdateClusterConfig"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:role/role-codebuild-kubernetes-deployment"]
    }
  }
}

data "aws_caller_identity" "current" {}