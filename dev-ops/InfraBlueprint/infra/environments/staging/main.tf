terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "vela-terraform-state"
    key    = "vela-payments-staging/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.vela_region
  default_tags {
    tags = {
      Project = "vela-payments"
      Env = "staging"
    }
  }
}

module "networking" {
  source = "../../modules/networking"
  vela_main_vpc_cidr        = var.vela_main_vpc_cidr
  vela_public_subnet_cidrs  = var.vela_public_subnet_cidrs
  vela_private_subnet_cidrs = var.vela_private_subnet_cidrs
  azs                       = var.azs
}

module "storage" {
  source = "../../modules/storage"

  vela_s3_bucket_name = var.vela_s3_bucket_name
}

module "compute" {
  source = "../../modules/compute"

  vela_vpc_id           = module.networking.vpc_id
  vela_public_subnet_id = module.networking.public_subnet_ids[0]
  vela_admin_ip_cidr    = var.vela_admin_ip_cidr
  vela_instance_type    = var.vela_instance_type
  vela_s3_bucket_arn    = module.storage.vela_s3_bucket_arn
}

module "database" {
  source = "../../modules/database"

  vela_vpc_id             = module.networking.vpc_id
  vela_private_subnet_ids = module.networking.private_subnet_ids
  vela_web_sg_id          = module.compute.vela_web_sg_id
  vela_db_username        = var.vela_db_username
  vela_db_password        = var.vela_db_password
}