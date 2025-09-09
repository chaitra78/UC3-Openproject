provider "aws" {
  region = var.aws_region
}


module "vpc" {
  source              = "./modules/vpc"
  vpc_id              = module.vpc.vpc_id
  availability_zones  = ["us-east-1a", "us-east-1b"]  # Adjust based on your region
}


module "ec2" {
  source             = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.vpc.ec2_sg_id]
  key_name           = var.key_name
}

module "alb" {
  source             = "./modules/alb"
  subnet_ids         = module.vpc.public_subnet_ids
  vpc_id             = module.vpc.vpc_id
  target_instance_id = module.ec2.instance_id
  ec2_sg_id          = module.vpc.ec2_sg_id
}

output "openproject_url" {
  value = module.alb.alb_dns_name
}
