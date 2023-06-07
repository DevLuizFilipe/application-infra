output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "Id da VPC"
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id
  description = "Id da subnet 1"
}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
  description = "Id da subnet 2"
}

output "security_group_id" {
  value = aws_security_group.security_group.id
  description = "Id do security group"
}
