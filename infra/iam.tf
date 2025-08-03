module "github_actions_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.28.0"

  create_role = true
  role_name   = "github-actions-eks-deploy-role"

  provider_url = "token.actions.githubusercontent.com"
#   oidc_subjects = [
#     "repo:YOUR_GITHUB_USER/YOUR_REPO_NAME:ref:refs/heads/main"
#   ]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  ]
}