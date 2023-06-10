output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "Id da VPC"
}

output "subnet1_id" {
  value       = aws_subnet.subnet1.id
  description = "Id da subnet 1"
}

output "subnet2_id" {
  value       = aws_subnet.subnet2.id
  description = "Id da subnet 2"
}

output "subnet3_id" {
  value       = aws_subnet.subnet3.id
  description = "Id da subnet 2"
}

output "security_group_id_ecs" {
  value       = aws_security_group.security_group_ecs.id
  description = "Id do security group ECS"
}

output "security_group_id_elb" {
  value       = aws_security_group.security_group_elb.id
  description = "Id do security group ELB"
}
