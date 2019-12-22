
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "tf_public_subnet_primary" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_public_subnet_primary"
  }
}

resource "aws_subnet" "tf_public_subnet_secondary" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_public_subnet_secondary"
  }
}

resource "aws_subnet" "tf_private_subnet" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}_private_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.name}_ig"
  }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.name}_route_table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.tf_public_subnet_primary.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.tf_public_subnet_secondary.id
  route_table_id = aws_route_table.r.id
}

output "vpc_id" {
  value = aws_vpc.default.id
}

output "gw" {
  value = aws_internet_gateway.gw
}

output "public_subnet_id_primary" {
  value = aws_subnet.tf_public_subnet_primary.id
}

output "public_subnet_id_secondary" {
  value = aws_subnet.tf_public_subnet_secondary.id
}

output "private_subnet_id" {
  value = aws_subnet.tf_private_subnet.id
}