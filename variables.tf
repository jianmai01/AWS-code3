variable "access" {
  default = "xxxxx"
  type    = string
}

variable "secret" {
  default = "xxx"
  type    = string
}

# no change
variable "region" {
  default = "ap-southeast-2"
}

variable "vpcs" {
    type = map(object({
    name                         = string
    vpc_cidr                     = string
    public_subnet_addresses      = string
    private_subnet1_addresses    = string
    private_subnet2_addresses    = string
    rds_admin_name               = string
    rds_admin_password           = string
    rds_engine_version           = string
    rds_instance_class           = string
    rds_time_zone                = string
    rds_allocated_storage_gb     = number
    rds_max_allocated_storage_gb = number
    ec2_ami                      = string
    ec2_size                     = string
    city                         = string 
    private_test_server_required = number       # 1 required  0 not required
    }))
}