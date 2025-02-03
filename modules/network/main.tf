resource "aws_vpc" "main" {
  cidr_block = var.network_config.vpc_cidr

  tags = {
    Name = var.network_config.vpc_name
  }
}

# Dynamic Public Subnets
resource "aws_subnet" "public" {
  for_each = { for idx, subnet in var.network_config.public_subnets : idx => subnet }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${each.key}"
  }
}

# Dynamic Private Subnets
resource "aws_subnet" "private" {
  for_each = { for idx, subnet in var.network_config.private_subnets : idx => subnet }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "private-${each.key}"
  }
}
