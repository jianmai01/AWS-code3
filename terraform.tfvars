
vpcs = {
    vpc1 = {
        name                         = "example"
        vpc_cidr                     = "10.0.0.0/24"
        public_subnet_addresses      = "10.0.0.0/27"
        private_subnet1_addresses    = "10.0.0.32/27"
        private_subnet2_addresses    = "10.0.0.64/27"
        rds_admin_name               = "exampleadmin" 
        rds_admin_password           = "LuYNmgfd09765hdodhds"
        rds_engine_version           = "16.00.4205.1.v1"
        rds_instance_class           = "db.m5.xlarge"
        rds_time_zone                = "AUS Eastern Standard Time"
        rds_allocated_storage_gb     = 300
        rds_max_allocated_storage_gb = 330
        ec2_ami                      = "ami-015845d4ba0b79c5e"
        ec2_size                     = "t3.large"
        city                         = "Sydney"
        private_test_server_required = 0       # 1 required  0 not required
}
    vpc2 = {
        name                         = "Care example"
        vpc_cidr                     = "10.0.1.0/24"
        public_subnet_addresses      = "10.0.1.0/27"
        private_subnet1_addresses    = "10.0.1.32/27"
        private_subnet2_addresses    = "10.0.1.64/27"
        rds_admin_name               = "careexampleadm" 
        rds_admin_password           = "LuYNmgfd09765hdodhds"
        rds_engine_version           = "16.00.4205.1.v1"
        rds_instance_class           = "db.m5.xlarge"
        rds_time_zone                = "AUS Eastern Standard Time"
        rds_allocated_storage_gb     = 200
        rds_max_allocated_storage_gb = 220
        ec2_ami                      = "ami-015845d4ba0b79c5e"
        ec2_size                     = "t3.large"
        city                         = "Melbourne"
        private_test_server_required = 0       # 1 required  0 not required
}
 vpc3 = {
        name                         = "Care test example"
        vpc_cidr                     = "10.0.2.0/24"
        public_subnet_addresses      = "10.0.2.0/27"
        private_subnet1_addresses    = "10.0.2.32/27"
        private_subnet2_addresses    = "10.0.2.64/27"
        rds_admin_name               = "careexampleadm" 
        rds_admin_password           = "LuYNmgfd09765hdodhds"
        rds_engine_version           = "16.00.4205.1.v1"
        rds_instance_class           = "db.m5.xlarge"
        rds_time_zone                = "AUS Eastern Standard Time"
        rds_allocated_storage_gb     = 200
        rds_max_allocated_storage_gb = 220
        ec2_ami                      = "ami-015845d4ba0b79c5e"
        ec2_size                     = "t3.large"
        city                         = "Melbourne"
        private_test_server_required = 0       # 1 required  0 not required
}
vpc4 = {
        name                         = "Care dev example"
        vpc_cidr                     = "10.0.3.0/24"
        public_subnet_addresses      = "10.0.3.0/27"
        private_subnet1_addresses    = "10.0.3.32/27"
        private_subnet2_addresses    = "10.0.3.64/27"
        rds_admin_name               = "careexampleadm" 
        rds_admin_password           = "LuYNmgfd09765hdodhds"
        rds_engine_version           = "16.00.4205.1.v1"
        rds_instance_class           = "db.m5.xlarge"
        rds_time_zone                = "AUS Eastern Standard Time"
        rds_allocated_storage_gb     = 200
        rds_max_allocated_storage_gb = 220
        ec2_ami                      = "ami-015845d4ba0b79c5e"
        ec2_size                     = "t3.large"
        city                         = "Melbourne"
        private_test_server_required = 0       # 1 required  0 not required
}
vpc5 = {
        name                         = "Care uat example"
        vpc_cidr                     = "10.0.4.0/24"
        public_subnet_addresses      = "10.0.4.0/27"
        private_subnet1_addresses    = "10.0.4.32/27"
        private_subnet2_addresses    = "10.0.4.64/27"
        rds_admin_name               = "careexampleadm" 
        rds_admin_password           = "LuYNmgfd09765hdodhds"
        rds_engine_version           = "16.00.4205.1.v1"
        rds_instance_class           = "db.m5.xlarge"
        rds_time_zone                = "AUS Eastern Standard Time"
        rds_allocated_storage_gb     = 200
        rds_max_allocated_storage_gb = 220
        ec2_ami                      = "ami-015845d4ba0b79c5e"
        ec2_size                     = "t3.large"
        city                         = "Melbourne"
        private_test_server_required = 0       # 1 required  0 not required
}
}


# RDS time zone
# "AUS Eastern Standard Time" - Sydney Melbourne Canberra
# "E. Australia Standard Time" - Brisbane
# "W. Australia Standard Time" - Perth
# "Cen. Australia Standard Time" - Adelaide
# "AUS Central Standard Time" - Darwin

