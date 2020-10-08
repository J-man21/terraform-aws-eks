locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

terraform {
  source = "../../../../modules/vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "${local.environment_vars.locals.project}-${local.environment_vars.locals.environment}"
}