resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_security_group" "security_group_ecs" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = [aws_security_group.security_group_elb.id]
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
    protocol    = var.vpc_security_group_ingress_protocol
    cidr_blocks = var.vpc_security_group_ingress_cidr_elb
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
    cidr_block     = var.vpc_route_table_cidr_block
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpc_route_table_cidr_block
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_subnet1_cidr_block
  availability_zone = var.vpc_subnet_region1
  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_subnet2_cidr_block
  availability_zone = var.vpc_subnet_region2
  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_subnet3_cidr_block
  availability_zone = var.vpc_subnet_region3
  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_route_table_association" "route_table_association_subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route_table_association" "route_table_association_subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route_table_association" "route_table_association_subnet3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet3.id
}
