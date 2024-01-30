resource "aws_vpc" "terraform-zweek2" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-zweek2"
    Project = local.global_tag
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.terraform-zweek2.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Public Subnet ${count.index + 1}"
    Project = local.global_tag
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.terraform-zweek2.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
    Project = local.global_tag
  }
}

resource "aws_internet_gateway" "this_gw" {
  vpc_id = aws_vpc.terraform-zweek2.id

  tags = {
    Name = "Terraform Infra IG"
    Project = local.global_tag
  }
}

resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.terraform-zweek2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this_gw.id
  }

  tags = {
    Name = "Terraform zweek rt"
    Project = local.global_tag
  }
}

resource "aws_route_table_association" "internet_access" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.internet.id
}
