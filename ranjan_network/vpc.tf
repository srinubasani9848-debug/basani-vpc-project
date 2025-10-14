provider "aws" {
  region = var.region
}

resource "aws_vpc" "ranjan_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name    = "ranjan-vpc"
    Project = "ranjan"
  }
}

resource "aws_subnet" "ranjan_public_subnet" {
  vpc_id                  = aws_vpc.ranjan_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  tags = {
    Name    = "ranjan-public-subnet"
    Project = "ranjan"
  }
}

resource "aws_subnet" "ranjan_private_subnet" {
  vpc_id            = aws_vpc.ranjan_vpc.id
  cidr_block        = var.private_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = "us-east-2a"
  tags = {
    Name    = "ranjan-private-subnet"
    Project = "ranjan"
  }
}

resource "aws_internet_gateway" "ranjan_igw" {
  vpc_id = aws_vpc.ranjan_vpc.id
  tags = {
    Name    = "ranjan-igw"
    Project = "ranjan"
  }
}

resource "aws_route_table" "ranjan_rt" {
  vpc_id = aws_vpc.ranjan_vpc.id
  tags = {
    Name    = "ranjan-rt"
    Project = "ranjan"
  }
}

resource "aws_route" "ranjan_route" {
  route_table_id         = aws_route_table.ranjan_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ranjan_igw.id
}

resource "aws_route_table_association" "ranjan_rta" {
  subnet_id      = aws_subnet.ranjan_public_subnet.id
  route_table_id = aws_route_table.ranjan_rt.id
}
