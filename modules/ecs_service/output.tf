output "service_id" {
  value       = aws_ecs_service.service.id
  description = "ID do service"
}
