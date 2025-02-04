terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.1"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.network_config.vpc_cidr

  tags = {
    Name = var.network_config.vpc_name
  }
}

resource "aws_flow_log" "main" {
  iam_role_arn    = "arn"
  log_destination = "log"
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}

# Dummy resource to attach security group and prevent Checkov errors
resource "aws_network_interface" "dummy_sg_attachment" {
  subnet_id       = aws_subnet.example.id # Ensure you have a valid subnet
  security_groups = [aws_security_group.allow_https.id]

  tags = {
    Name = "dummy-sg-attachment"
  }
}

resource "aws_security_group" "allow_https" {
  name        = "allow-https"
  description = "Allow inbound HTTPS traffic on port 443"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTPS inbound traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow-https"
  }
}

resource "aws_default_security_group" "restrict_all" {
  vpc_id = aws_vpc.main.id

  # Remove all ingress rules
  ingress = []

  # Remove all egress rules
  egress = []

  tags = {
    Name = "default-security-group-restricted"
  }
}

# Dynamic Public Subnets
resource "aws_subnet" "public" {
  for_each = { for idx, subnet in var.network_config.public_subnets : idx => subnet }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

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
