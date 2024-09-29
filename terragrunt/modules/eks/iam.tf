resource "aws_iam_role" "eks_deploy" {
  name               = "role-${var.env}-eks-deployment"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  inline_policy {
    name   = "policy-${var.env}-eks-deployment"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}

resource "aws_iam_policy" "eks_describe" {
  name   = "policy-${var.env}-eks-describe-cluster"
  policy = jsonencode({
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "eks:DescribeCluster",
        "Resource" : "arn:aws:eks:eu-west-1:391611208234:cluster/eks-${var.env}"
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : "eks:ListClusters",
        "Resource" : "*"
      }
    ],
    "Version" : "2012-10-17"
  })
}