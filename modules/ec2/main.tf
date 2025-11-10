resource "aws_instance" "ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_size
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  monitoring                  = true  # Enables detailed monitoring
  disable_api_termination     = true
  key_name                    = var.key_pair_name
  iam_instance_profile        = var.ec2_iam_instance_profile

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"  # IMDSv2 only
    http_put_response_hop_limit = 2
  }

  root_block_device {
    volume_size = 100                     # Modify as needed
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = "alias/aws/ebs"        # AWS-managed key
    delete_on_termination = true
    tags = {
      Name = var.ec2_tag
    }
  }

  tags = {
    Name        = var.ec2_tag
    Customer      = "${var.customer_name}"
    "Patch Group" = "Production-Servers-Patch-Group"
  }
}

