locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

terraform {
  source = "../../../.."
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