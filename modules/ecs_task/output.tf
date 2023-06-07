output "task_arn" {
  value = aws_ecs_task_definition.task_definition.arn
}

output "task_container_name" {
  value = var.ecs_task_container_name
}

output "task_container_port" {
  value = var.ecs_task_container_port
}
