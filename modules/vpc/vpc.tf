resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}




resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.cidr_block : idx => cidr }

  cidr_block        = each.value
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zones[each.key]  # Optional, if you're mapping AZs
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${each.key}"
  }
}


resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
