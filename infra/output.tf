output "eks_cluster_name" {
  value = module.eks_cluster.cluster_name
}

output "aws_region" {
  value = var.aws_region
}

output "github_actions_role_arn" {
  value = module.github_actions_iam_role.iam_role_arn
}

output "backend_ecr_repo_url" {
  value = module.ecr_backend.repository_url
}

output "frontend_ecr_repo_url" {
  value = module.ecr_frontend.repository_url
}
