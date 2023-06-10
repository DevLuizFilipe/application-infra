variable "ecs_task_family" {
  type        = string
  description = "Nome da task ECS"
}

variable "ecs_task_role_arn" {
  type        = string
  description = "ARN da role ECS"
}

variable "ecs_task_compatibilities" {
  type        = list(string)
  description = "Tipo da task ECS"
}

variable "ecs_task_container_name" {
  type        = string
  description = "Nome do container"
}

variable "ecs_task_container_image" {
  type        = string
  description = "Imagem do container"
}

variable "ecs_task_container_port" {
  type        = number
  description = "Porta do container"
}

variable "ecs_task_port" {
  type        = number
  description = "Porta da task"
}

variable "ecs_task_memory" {
  type        = number
  description = "Memoria da task"
}

variable "ecs_task_cpu" {
  type        = number
  description = "CPU da task"
}
