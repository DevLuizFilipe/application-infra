output "task_arn" {
  value = aws_ecs_task_definition.task_definition.arn
  description = "ARN da task definition ECS"
}

output "task_container_name" {
  value = var.ecs_task_container_name
  description = "Nome do container"
}

output "task_container_port" {
  value = var.ecs_task_container_port
  description = "Porta do container"
}
