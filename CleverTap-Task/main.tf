terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.47.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source                     = "./vpc" // Assuming the module is in the same directory
  vpc_cidr_block             = "10.0.0.0/16"
  public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

module "sg" {
  source                  = "./sg"
  vpc_id                  = module.vpc.vpc_id
  alb_security_group_name = "alb-security-group"
  ec2_security_group_name = "ec2-security-group"
  rds_security_group_name = "rds-security-group"
}


module "rds" {
  source = "./rds"

  db_instance_class    = "db.t3.micro"
  db_engine            = "mysql"
  db_engine_version    = "8.0"
  db_allocated_storage = 20
  db_name              = "wordpressdb"
  db_username          = "admin"
  db_password          = "mayank1999"
  db_subnet_group_name = "db-subnet-group"
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  rds_security_group_ids = [ module.sg.rds_security_group_id ]

}

output "db_endpoint" {
  value = module.rds.db_endpoint
}
/*
module "ec2_instances" {
  source = "./ec2" # Path to your EC2 instance module directory

  instance_count = 1
  instance_type  = "t2.micro"
  ami_id         = "ami-02faaf8bb6ffc8fab" 

  subnet_ids         = module.vpc.public_subnet_ids               # Reference subnet IDs from VPC module
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"] # Reference availability zones from VPC module
}

output "ec2_instance_ids" {
  value = module.ec2_instances.instance_ids
}

output "ec2_instance_public_ips" {
  value = module.ec2_instances.public_ip_addresses
}

output "ec2_instance_private_ips" {
  value = module.ec2_instances.private_ip_addresses
}*/

module "alb" {
  source                = "./alb"
  vpc_id                = module.vpc.vpc_id
  alb_name              = "wordpress-alb"
  subnet_ids            = module.vpc.public_subnet_ids
  target_group_name     = "wordpress-tg"
  target_group_port     = 80
  target_group_protocol = "HTTP"
  ssl_certificate_arn   = module.ssl.certificate_arn
  #instance_ids               = module.ec2_instances.instance_ids
  alb_security_group_id      = [module.sg.alb_security_group_id]
  server_security_group_name = module.sg.ec2_security_group_name
}

module "asg" {
  source = "./asg" # Update the path as per your directory structure

  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  asg_desired_capacity = var.asg_desired_capacity
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  ec2_ami_id           = var.ec2_ami_id
  ec2_instance_type    = var.ec2_instance_type
  key_name             = var.key_name
  public_subnet_ids    = module.vpc.public_subnet_ids
  target_group_arns    = [module.alb.target_group_arns]
  security_group_ids   = [module.sg.ec2_security_group_id]
}

# Module calling block for DNS Configuration module
module "dns" {
  source = "./dns"


  domain_name     = "mayanktech.online"
  elb_dns_name    = module.alb.alb_dns_name
  elb_dns_zone_id = module.alb.alb_dns_zone_id
}

# Module calling block for SSL/TLS Setup module
module "ssl" {
  source = "./ssl"

  domain_name = "mayanktech.online"
  route53_zone_id = module.dns.route53_zone_id
}


