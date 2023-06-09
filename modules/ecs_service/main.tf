resource "aws_ecs_service" "service" {
  name            = var.ecs_service_name
  cluster         = var.ecs_service_cluster
  task_definition = var.ecs_service_task
  desired_count   = var.ecs_service_count

  load_balancer {
    target_group_arn = var.ecs_service_target_group_arn
    container_name   = var.ecs_service_container_name
    container_port   = var.ecs_service_container_port
  }

  network_configuration {
    subnets         = var.ecs_service_subnets
    security_groups = var.ecs_service_security_groups
  }
}
