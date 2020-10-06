locals {
  cluster_name = "eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source = "./../modules/vpc"
}

module "test" {
  source = "./.."

  cluster_name = local.cluster_name
  vpc_id = module.vpc.vpc_id
  vpc_private_subnets = module.vpc.vpc_private_subnets
}