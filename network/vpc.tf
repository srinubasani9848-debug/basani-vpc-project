provider "aws" {
  region = var.region
}

resource "aws_vpc" "srinivas_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name    = "srinivas-vpc"
    Project = "srinivas"
  }
}

resource "aws_subnet" "srinivas_public_subnet" {
  vpc_id                  = aws_vpc.srinivas_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name    = "srinivas-public-subnet"
    Project = "srinivas"
  }
}

resource "aws_subnet" "srinivas_private_subnet" {
  vpc_id            = aws_vpc.srinivas_vpc.id
  cidr_block        = var.private_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
  tags = {
    Name    = "srinivas-private-subnet"
    Project = "srinivas"
  }
}

resource "aws_internet_gateway" "srinivas_igw" {
  vpc_id = aws_vpc.srinivas_vpc.id
  tags = {
    Name    = "srinivas-igw"
    Project = "srinivas"
  }
}

resource "aws_route_table" "srinivas_rt" {
  vpc_id = aws_vpc.srinivas_vpc.id
  tags = {
    Name    = "srinivas-rt"
    Project = "srinivas"
  }
}

resource "aws_route" "srinivas_route" {
  route_table_id         = aws_route_table.srinivas_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.srinivas_igw.id
}

resource "aws_route_table_association" "srinivas_rta" {
  subnet_id      = aws_subnet.srinivas_public_subnet.id
  route_table_id = aws_route_table.srinivas_rt.id
}

