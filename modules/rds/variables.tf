variable "vpc_id" {
    type = string
}

variable "customer_name" {
    type = string
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

variable "private_security_group_id" {
    type = string
}

variable "public_security_group_id" {
    type = string
}

variable "private_subnet1_id" {
    type = string
}

variable "private_subnet2_id" {
    type = string
}

variable "backup_role_name" {
    type = string
}
