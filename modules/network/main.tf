# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.customer_name} IGW"
  }
}


# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_addresses
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.customer_name} public subnet"
  }
}



# Private Subnet1
resource "aws_subnet" "private1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet1_addresses
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "${var.customer_name} private subnet 1"
  }
}


# Private Subnet2
resource "aws_subnet" "private2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet2_addresses
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "${var.customer_name} private subnet 2"
}
}


# Elastic IP for NAT
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.customer_name} NAT"
  }
}

# NAT Gateway (in the public subnet) 
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.customer_name} NAT Gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Route Table - Public
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.customer_name} public RT"
  }
}

# Route to Internet for Public Subnet
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnet with Public RT 
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Add Route to Internet via NAT Gateway for Main Route Table
 resource "aws_route" "main_default_route" {
  route_table_id          = var.main_route_table_id 
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = aws_nat_gateway.nat.id
 }


# Tag the main route table
resource "aws_ec2_tag" "main_route_table_tag" {
  resource_id = var.main_route_table_id 
  key         = "Name"
  value       = "${var.customer_name} Main RT"
}

# Security Group for Public server
resource "aws_security_group" "public_sg" {
  name        = "${var.customer_name} Public Server SG"
  description = "${var.customer_name} Public Server SG"
  vpc_id      = var.vpc_id


# Ingress (inbound) rule - allow all HTTPS
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  #  Open to all IPs – restrict in production
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
    Name  = "${var.customer_name} Public Server SG"
  }
}

# Security Group for Private server
resource "aws_security_group" "private_sg" {
  name        = "${var.customer_name} Private Server SG"
  description = "${var.customer_name} Private Server SG"
  vpc_id      = var.vpc_id


  ingress {
    from_port                = 3389
    to_port                  = 3389
    protocol                 = "tcp"
    description              = "Allow RDP from public SG"
    security_groups          = [aws_security_group.public_sg.id]
  }

  ingress {
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    description              = "Allow HTTPS from public SG"
    security_groups          = [aws_security_group.public_sg.id]
  }

    ingress {
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    description              = "Allow HTTP from public SG"
    security_groups          = [aws_security_group.public_sg.id]
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
    Name  = "${var.customer_name} Private Server SG"
  }
}