# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.customer_name} VPC"
    Customer = "${var.customer_name}"
  }
}

# VPC Flow logs
resource "aws_flow_log" "vpc_reject_logs" {
  log_destination      = "arn:aws:logs:ap-southeast-2:198861357956:log-group:FlowLog/CivicaCareLogGroup:*"
  iam_role_arn         = "arn:aws:iam::198861357956:role/FlowLogs_CloudWatchLogs_Role"
  traffic_type         = "REJECT"
  vpc_id               = aws_vpc.main.id
  log_destination_type = "cloud-watch-logs"
  max_aggregation_interval = 600 # 10 minutes

  log_format = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status}"
  tags = {
    Name      = "${(replace(lower(var.customer_name), " ", "-"))}${"-flow-log"}"
    Customer  = "${var.customer_name}"
  }
}


# Create Network
module "network" {
  source                      = "../network"
  customer_name               = var.customer_name
  vpc_id                      = aws_vpc.main.id
  main_route_table_id         = aws_vpc.main.main_route_table_id
  public_subnet_addresses     = var.public_subnet_addresses
  private_subnet1_addresses   = var.public_subnet_addresses
  private_subnet2_addresses   = var.public_subnet_addresses
}

# Create key_pair 
module "key_pair" {
  source                    = "../key_pair"
  customer_name             = var.customer_name
}

# Create Public server 
module "public_server" {
  source                      = "../ec2"
  customer_name               = var.customer_name
  ec2_tag                     = "${var.customer_name} Public Server - ${var.city}"
  ec2_size                    = var.ec2_size
  ec2_ami                     = var.ec2_ami
  subnet_id                   = module.network.public_subnet_id
  security_group_id           = module.network.public_security_group_id
  city                        = var.city
  key_pair_name               = module.key_pair.key_pair_name
  ec2_iam_instance_profile    = "CarelinkWebInstanceRoleProfile"
}

# Attach Elastic IP (EIP) to public server
resource "aws_eip" "ec2_eip" {
  instance = module.public_server.ec2_id

  tags = {
    Name        = "${var.customer_name} Public Server"
    Customer    = "${var.customer_name}"
  }
}


# Create Private server 
module "private_server" {
  source                      = "../ec2"
  customer_name               = var.customer_name
  ec2_tag                     = "${var.customer_name} Private Server - ${var.city}"
  ec2_size                    = var.ec2_size
  ec2_ami                     = var.ec2_ami
  subnet_id                   = module.network.private_subnet1_id
  security_group_id           = module.network.private_security_group_id
  city                        = var.city
  key_pair_name               = module.key_pair.key_pair_name
  ec2_iam_instance_profile    = "CarelinkAppInstanceRoleProfile"
}

# Create Private Test server 
module "private_test_server" {
  count = var.private_test_server_required
  source                      = "../ec2"
  customer_name               = var.customer_name
  ec2_tag                     = "${var.customer_name} Private Test Server - ${var.city}"
  ec2_size                    = var.ec2_size
  ec2_ami                     = var.ec2_ami
  subnet_id                   = module.network.private_subnet1_id
  security_group_id           = module.network.private_security_group_id
  city                        = var.city
  key_pair_name               = module.key_pair.key_pair_name
  ec2_iam_instance_profile    = "CarelinkAppInstanceRoleProfile"
}


# Create S3 bucket
module "s3" {
  source              = "../s3"
  customer_name       = var.customer_name
}


# Create RDS
module "rds" {
  source                       = "../rds"
  customer_name                = var.customer_name
  rds_admin_name               = var.rds_admin_name
  rds_admin_password           = var.rds_admin_password
  rds_engine_version           = var.rds_engine_version
  rds_instance_class           = var.rds_instance_class
  rds_time_zone                = var.rds_time_zone 
  rds_allocated_storage_gb     = var.rds_allocated_storage_gb
  rds_max_allocated_storage_gb = var.rds_max_allocated_storage_gb
  backup_role_name             = module.s3.aws_backup_role_name
  public_security_group_id     = module.network.public_security_group_id
  private_security_group_id    = module.network.private_security_group_id
  vpc_id                       = aws_vpc.main.id
  private_subnet1_id           = module.network.private_subnet1_id
  private_subnet2_id           = module.network.private_subnet2_id
}


# Create Dashboard
module "dashboard" {
  source                = "../dashboard"
  customer_name         = var.customer_name
  public_server_id      = module.public_server.ec2_id
  private_server_id     = module.private_server.ec2_id
  public_server_type    = module.public_server.ec2_type
  private_server_type   = module.private_server.ec2_type
  ec2_ami               = var.ec2_ami
  rds_id                = module.rds.rds_id

}