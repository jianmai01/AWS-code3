provider "aws" {
  region = var.region
  access_key = var.access
  secret_key = var.secret
}


# Create vpc
module "vpc" {
  for_each                      = var.vpcs
  source                        = "./modules/vpc"
  customer_name                 = each.value.name
  vpc_cidr                      = each.value.vpc_cidr
  public_subnet_addresses       = each.value.public_subnet_addresses
  private_subnet1_addresses     = each.value.private_subnet1_addresses
  private_subnet2_addresses     = each.value.private_subnet2_addresses
  city                          = each.value.city
  ec2_size                      = each.value.ec2_size
  ec2_ami                       = each.value.ec2_ami
  private_test_server_required  = each.value.private_test_server_required
  rds_admin_name                = each.value.rds_admin_name
  rds_admin_password            = each.value.rds_admin_password
  rds_engine_version            = each.value.rds_engine_version
  rds_instance_class            = each.value.rds_instance_class
  rds_time_zone                 = each.value.rds_time_zone 
  rds_allocated_storage_gb      = each.value.rds_allocated_storage_gb
  rds_max_allocated_storage_gb  = each.value.rds_max_allocated_storage_gb
}




