variable "elb_name" {
  type        = string
  description = "Nome do load balancer"
}

variable "elb_type" {
  type        = string
  description = "Tipo do load balancer"
}

variable "elb_subnets" {
  type        = list(string)
  description = "Subnets do load balancer"
}

variable "elb_target_group_name" {
  type        = string
  description = "Nome do target group"
}

variable "elb_target_group_port" {
  type        = string
  description = "Porta do target group"
}

variable "elb_target_group_protocol" {
  type        = string
  description = "Protocolo do target group"
}

variable "elb_target_group_vpc" {
  type        = string
  description = "VPC do target group"
}

variable "elb_group_target_heatlh_interval" {
  type        = string
  description = "Intervalo de checagem de saúde da aplicação"
}

variable "elb_group_target_heatlh_path" {
  type        = string
  description = "Caminho de checagem de saúde da aplicação"
}

variable "elb_group_target_heatlh_port" {
  type        = string
  description = "Porta de checagem de saúde da aplicação"
}

variable "elb_group_target_heatlh_protocol" {
  type        = string
  description = "Protocolo de checagem de saúde da aplicação"
}

variable "elb_group_target_heatlh_timeout" {
  type        = string
  description = "Timeout de checagem de saúde da aplicação"
}

variable "elb_group_target_heatlh_threshold" {
  type        = string
  description = "Threshold de checagem de saúde da aplicação"
}

variable "elb_group_target_unhealthy_threshold" {
  type        = string
  description = "Threshold de checagem de saúde da aplicação"
}

variable "elb_listener_port" {
  type        = string
  description = "Porta do listener"
}

variable "elb_listener_protocol" {
  type        = string
  description = "Protocolo do listener"
}

variable "elb_listener_type" {
  type        = string
  description = "Tipo do listener"
}
