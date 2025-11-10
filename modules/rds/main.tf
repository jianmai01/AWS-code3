# RDS Option Group
resource "aws_db_option_group" "sql_option_group" {
  name                      = "${"carelink-"}${(replace(lower(var.customer_name), " ", "-"))}${"-rds-og"}"
  engine_name               = "sqlserver-se"
  major_engine_version       = "16.00"
  option_group_description  = "${"carelink-"}${(replace(lower(var.customer_name), " ", "-"))}${"-rds-og"}"
  option {
    option_name         = "SQLSERVER_BACKUP_RESTORE"
    option_settings {
    name  = "IAM_ROLE_ARN"
    value = "arn:aws:iam::198861357956:role/${var.backup_role_name}"
  }
}
  tags =  {
    Name = "${"carelink-"}${(replace(lower(var.customer_name), " ", "-"))}${"-rds-og"}"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${lower(var.customer_name)}${" rds subnet group"}"
  subnet_ids  = [
          var.private_subnet1_id,
          var.private_subnet2_id
          ]
  description = "${var.customer_name} rds subnet group"

  tags        = {
    Name      = "${lower(var.customer_name)}${" rds subnet group"}"
    Customer  = "${var.customer_name}"
  }

}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.customer_name} RDS SG"
  description = "${var.customer_name} RDS SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port                = 1433
    to_port                  = 1433
    protocol                 = "tcp"
    description              = "Allow SQL Port from public SG"
    security_groups          = [var.public_security_group_id]
  }

  ingress {
    from_port                = 1433
    to_port                  = 1433
    protocol                 = "tcp"
    description              = "Allow SQL port from private SG"
    security_groups          = [var.private_security_group_id]
  }

   # Egress (outbound) rule - allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow to anywhere
    description = "Allow all outbound traffic"
  }

  tags = {
    Name  = "${var.customer_name} RDS SG"
  }
}



# RDS SQL Server (dev/test)
resource "aws_db_instance" "sqlserver" {
  identifier                  = "${"carelink-"}${(replace(lower(var.customer_name), " ", "-"))}${"-rds"}"
  engine                      = "sqlserver-se"
  engine_version              = var.rds_engine_version
  license_model               = "license-included"
  instance_class              = var.rds_instance_class
  allocated_storage           = var.rds_allocated_storage_gb
  max_allocated_storage       = var.rds_max_allocated_storage_gb
  storage_type                = "gp3"
  storage_encrypted           = true
  #kms_key_id                 = "aws/rds"

  db_subnet_group_name        = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids      = [aws_security_group.rds_sg.id]
  availability_zone           = "ap-southeast-2b"
  network_type                = "IPV4"
  publicly_accessible         = false
  port                        = 1433

  username                    = var.rds_admin_name
  password                    = var.rds_admin_password
  
  # No Windows Authentication
  domain                      = null            # <-- This disables Active Directory integration

  parameter_group_name        = "sqlserver-se-16-0-force-ssl-on"
  option_group_name           = aws_db_option_group.sql_option_group.name

  timezone                    = var.rds_time_zone

  # Backup
  backup_retention_period     = 35
  backup_window               = "15:00-17:00"
  copy_tags_to_snapshot       = true

  # Maintenance
  maintenance_window          = "sat:13:00-sat:14:00"
  auto_minor_version_upgrade  = true
  deletion_protection         = true

  # Enhanced Monitoring
  monitoring_interval         = 60
  monitoring_role_arn         = "arn:aws:iam::198861357956:role/rds-monitoring-role"
  # Dev/Test conveniences
  multi_az                    = false
  apply_immediately           = false
  
  # Performance Insights configuration
  performance_insights_enabled       = true
  performance_insights_kms_key_id    = "arn:aws:kms:ap-southeast-2:198861357956:key/09700473-14bc-4816-b992-17f323c3bc1e"
  performance_insights_retention_period = 7

  # Option final snapshot settings when deletion_protection is later turned off
  skip_final_snapshot         = false
  # Enable publishing of Agent and Error logs to CloudWatch
  enabled_cloudwatch_logs_exports = ["agent", "error"]
  tags = {
    Customer      = "${var.customer_name}"
}
}
