
output "eks_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.eks.eks_oidc_issuer_url
}

output "eks_oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`."
  value       = module.eks.eks_oidc_provider_arn
}

output "eks_cluster_id" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.eks_cluster_id
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = module.eks.configure_kubectl
}

output "cluster_security_group_id" {
  description = "EKS Control Plane Security Group ID"
  value       = module.eks.cluster_security_group_id
}

output "cluster_primary_security_group_id" {
  description = "EKS Cluster Security group ID"
  value       = module.eks.cluster_primary_security_group_id
}

output "worker_security_group_id" {
  description = "EKS Worker Security group ID created by EKS module"
  value       = module.eks.self_managed_node_group_iam_role_arns
}
