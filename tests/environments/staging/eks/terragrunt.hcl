locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

terraform {
  source = "../../../../modules/eks"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  cluster_name = "${local.environment_vars.locals.project}-${local.environment_vars.locals.environment}"
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_private_subnets = dependency.vpc.outputs.vpc_private_subnets
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}
EOF
}