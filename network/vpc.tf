provider "aws" {
  region = var.region
}

resource "aws_vpc" "basani_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "basani-vpc"
    Project = "basani"
  }
}

resource "aws_subnet" "basani_subnet" {
  vpc_id                  = aws_vpc.basani_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name    = "basani-subnet"
    Project = "basani"
  }
}

resource "aws_internet_gateway" "basani_igw" {
  vpc_id = aws_vpc.basani_vpc.id
  tags = {
    Name    = "basani-igw"
    Project = "basani"
  }
}

resource "aws_route_table" "basani_rt" {
  vpc_id = aws_vpc.basani_vpc.id
  tags = {
    Name    = "basani-rt"
    Project = "basani"
  }
}

resource "aws_route" "basani_route" {
  route_table_id         = aws_route_table.basani_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.basani_igw.id
}

resource "aws_route_table_association" "basani_rta" {
  subnet_id      = aws_subnet.basani_subnet.id
  route_table_id = aws_route_table.basani_rt.id
}
