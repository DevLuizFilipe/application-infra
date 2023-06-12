output "target_group_arn" {
  value       = aws_lb_target_group.target_group.arn
  description = "ARN do target group"
}

output "elb_id" {
  value       = aws_lb.elb.id
  description = "ID do load balancer"
}

output "dns_name" {
  value       = aws_lb.elb.dns_name
  description = "DNS do load balancer"
}
