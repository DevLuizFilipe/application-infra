resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_security_group" "security_group_ecs" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = "0"
    to_port         = "0"
    protocol        = "-1"
    security_groups = [aws_security_group.security_group_elb.id]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "security_group_elb" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = var.vpc_security_group_ingress_from_port_elb
    to_port     = var.vpc_security_group_ingress_to_port_elb
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_subnet" "subnet_private" {
  count             = var.vpc_subnet_private_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_subnet_private_cidr_block_base, 1, count.index)
  availability_zone = var.vpc_subnet_private_region
}

resource "aws_subnet" "subnet_public" {
  count             = var.vpc_subnet_public_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_subnet_public_cidr_block_base, 1, count.index)
  availability_zone = var.vpc_subnet_public_region
}

resource "aws_route_table_association" "route_table_association_subnet_private" {
  count          = var.vpc_subnet_private_count
  subnet_id      = aws_subnet.subnet_private[count.index].id
  route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route_table_association" "route_table_association_subnet_public" {
  count          = var.vpc_subnet_public_count
  subnet_id      = aws_subnet.subnet_public[count.index].id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet_public[0].id
}
