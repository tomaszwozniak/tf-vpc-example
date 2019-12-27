# Specify the provider and access details
provider "aws" {
  region = var.aws_region
  version = "2.43.0"
}


module "network" {
  source = "./network"
  name = var.name
}


module "security" {
  source = "./security"

  vpc_id = module.network.vpc_id
  gw = module.network.gw
  name = var.name
}


module "applications" {
  source = "./applications"

  aws_amis = var.aws_amis
  key_name = var.key_name
  aws_region = var.aws_region
  name = var.name
  zone_id = var.zone_id

  public_subnet_id_secondary = module.network.public_subnet_id_primary
  public_subnet_id_primary = module.network.public_subnet_id_secondary
  alb_sg_id = module.security.alb_sg_id
  web_sg_id = module.security.web_sg_id
  private_subnet_id = module.network.private_subnet_id
  bastion_sg_id = module.security.bastion_sg_id
  vpc_id = module.network.vpc_id
}
