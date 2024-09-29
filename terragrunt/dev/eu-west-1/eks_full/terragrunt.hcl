terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/eks"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", "../rds"]
}


dependency "vpc" {
  config_path = "../vpc"
}

dependency "rds" {
  config_path = "../rds"
}

inputs = {
  cluster_version     = "1.22"
  vpc_id              = dependency.vpc.outputs.vpc_id
  eks_subnet_ids      = dependency.vpc.outputs.eks_subnets
  # TODO: put all values
}
