module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
}

module "eks" {
  source = "./modules/eks"
  aws_profile = var.aws_profile
  prefix = var.prefix
  vpc_id = module.vpc.vpc_id
  cluster_name = var.cluster_name
  cloudwatch_retention_days_log = var.cloudwatch_retention_days_log
  subnet_ids = module.vpc.subnet_ids
  node_desired_size = var.node_desired_size
  node_max_size = var.node_max_size
  node_min_size = var.node_min_size
}