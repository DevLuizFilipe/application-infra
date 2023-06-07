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

variable "ecs_service_subnets" {
  type        = list(string)
  description = "Subnets do service"
}

variable "ecs_service_security_groups" {
  type        = list(string)
  description = "Security groups do service"
}

variable "ecs_service_elb_arn" {
  type        = string
  description = "ARN do ELB"
}

variable "ecs_service_elb_container" {
  type        = string
  description = "Container do ELB"
}

variable "ecs_service_elb_container_port" {
  type        = string
  description = "Porta do container do ELB"
}
