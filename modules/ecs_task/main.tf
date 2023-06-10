resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.ecs_task_family
  execution_role_arn       = var.ecs_task_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = var.ecs_task_compatibilities
  memory                   = var.ecs_task_memory
  cpu                      = var.ecs_task_cpu

  container_definitions = jsonencode([
    {
      name  = var.ecs_task_container_name
      image = var.ecs_task_container_image
      portMappings = [
        {
          containerPort = var.ecs_task_container_port,
          hostPort      = var.ecs_task_port,
          protocol      = "tcp"
        }
      ]
    }
  ])
}
