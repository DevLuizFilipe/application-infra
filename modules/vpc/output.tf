output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "Id da VPC"
}

output "subnet_private_id" {
  value       = aws_subnet.subnet_private[*].id
  description = "Id da subnet privada"
}

output "subnet_public_id" {
  value       = aws_subnet.subnet_public[*].id
  description = "Id da subnet publica"
}

output "security_group_id_ecs" {
  value       = aws_security_group.security_group_ecs.id
  description = "Id do security group ECS"
}

output "security_group_id_elb" {
  value       = aws_security_group.security_group_elb.id
  description = "Id do security group ELB"
}
