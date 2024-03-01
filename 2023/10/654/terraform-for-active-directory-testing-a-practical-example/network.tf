# Create the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.aws_az
}

## PRIVATE ROUTING
# PrivateRouteTable
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
}

# PrivateSubnet1RouteTableAssociation
resource "aws_route_table_association" "perf-crta-private-subnet-1" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}

# Define the public subnet
resource "aws_subnet" "public-subnet" {
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.aws_az
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

# Define the public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Assign the public route table to the public subnet
resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_vpc_dhcp_options" "vpc-dhcp-options" {
  domain_name_servers = [aws_instance.windows-server-dc.private_ip]
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.vpc-dhcp-options.id
}

# Define the security group for the Windows server
resource "aws_security_group" "aws-windows-sg" {
  name        = "windows-sg"
  description = "Allow incoming connections"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["1.1.1.1/32"]
    description = "Allow incoming connections from me"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    self        = true
    description = "Allow All Connections From VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "windows-sg"
  }
}

# Define the security group for the Windows server
resource "aws_security_group" "aws-windows-private-sg" {
  name        = "windows-private-sg"
  description = "Allow incoming connections"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    self        = true
    description = "Allow All Connections From VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "windows-private-sg"
  }
}
