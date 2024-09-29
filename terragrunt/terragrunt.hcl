locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
//  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  aws_account = local.account_vars.locals.account
  aws_role   = local.account_vars.locals.aws_role
  aws_region = local.region_vars.locals.aws_region
//  env        = local.environment_vars.locals.common_vars.env
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket


generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
    required_version = ">= 0.14.5"
      backend "s3" {}
}
EOF
}

remote_state {
  backend = "s3"
  config = {

    #global
    role_arn = local.aws_role
    bucket = "terraform-state-simple-web-app-${local.aws_account}-${local.aws_region}"
    encrypt = true
    skip_bucket_versioning = false

    key            = "terragrunt/${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "terraform-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  version = "= 3.73.0"
  region = "${local.aws_region}"
  assume_role {
    role_arn = "${local.aws_role}"
    session_name = "terragrunt"
  }
}
EOF
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals
//  local.environment_vars.locals,
//  local.environment_vars.locals.common_vars
)

