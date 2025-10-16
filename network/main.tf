provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "srinivas_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "srinivas-vpc"
    Project = "srinivas"
  }
}

# Public Subnet
resource "aws_subnet" "srinivas_public_subnet" {
  vpc_id                  = aws_vpc.srinivas_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az

  tags = {
    Name    = "srinivas-public-subnet"
    Project = "srinivas"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "srinivas_igw" {
  vpc_id = aws_vpc.srinivas_vpc.id

  tags = {
    Name    = "srinivas-igw"
    Project = "srinivas"
  }
}

# Public Route Table
resource "aws_route_table" "srinivas_public_rt" {
  vpc_id = aws_vpc.srinivas_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.srinivas_igw.id
  }

  tags = {
    Name    = "srinivas-public-rt"
    Project = "srinivas"
  }
}

# Associate Route Table
resource "aws_route_table_association" "srinivas_public_rta" {
  subnet_id      = aws_subnet.srinivas_public_subnet.id
  route_table_id = aws_route_table.srinivas_public_rt.id
}
