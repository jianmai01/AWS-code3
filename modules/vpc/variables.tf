variable "customer_name" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

/*
variable "availability_zones" {
    type = list(string)
}
*/

variable "public_subnet_addresses" {
    type = string
}

variable "private_subnet1_addresses" {
    type = string
}

variable "private_subnet2_addresses" {
    type = string
}

variable "city" {
    type = string
}

variable "ec2_size" {
    type = string
}

variable "ec2_ami" {
    type = string
}

variable "private_test_server_required" {
    type = number
}

variable "rds_admin_name" {
    type = string
}

variable "rds_admin_password" {
    type = string
}

variable "rds_engine_version" {
    type = string
}

variable "rds_instance_class" {
    type = string
}

variable "rds_time_zone" {
    type = string
}

variable "rds_allocated_storage_gb" {
    type = number
}

variable "rds_max_allocated_storage_gb" {
    type = number
}

