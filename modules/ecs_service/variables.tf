variable "ecs_service_name" {
  type        = string
  description = "Nome do service"
}

variable "ecs_service_cluster" {
  type        = string
  description = "Cluster do service"
}

variable "ecs_service_task" {
  type        = string
  description = "Task do service"
}

variable "ecs_service_count" {
  type        = string
  description = "Quantidade de replicas da aplicação"
}

variable "ecs_service_type" {
  type        = string
  description = "Tipo de launch type"
}

variable "ecs_service_target_group_arn" {
  type        = string
  description = "ARN do target group"
}

variable "ecs_service_container_name" {
  type        = string
  description = "Nome do container"
}

variable "ecs_service_container_port" {
  type        = string
  description = "Porta do container"
}

variable "ecs_service_subnets" {
  type        = list(string)
  description = "Subnets do service"
}

variable "ecs_service_security_groups" {
  type        = list(string)
  description = "Security groups do service"
}
