variable "vpc_name" {
  type        = string
  description = "Nome da VPC"
}

variable "vpc_subnet_private_count" {
  type        = number
  description = "Quantidade de subnets privadas"
}

variable "vpc_subnet_public_count" {
  type        = number
  description = "Quantidade de subnets publicas"
}

variable "vpc_cidr_block" {
  type        = string
  description = "default 10.0.0.0/16"
}

variable "vpc_security_group_ingress_from_port_elb" {
  type        = string
  description = "Porta de origem do ELB"
}

variable "vpc_security_group_ingress_to_port_elb" {
  type        = string
  description = "Porta de destino do ELB"
}

variable "vpc_subnet_private_cidr_block_base" {
  description = "Base do CIDR da subnet privada"
}

variable "vpc_subnet_public_cidr_block_base" {
  description = "Base do CIDR da subnet pública"
}

variable "vpc_subnet_private_region" {
  type        = string
  description = "Região da subnet privada"
}

variable "vpc_subnet_public_region" {
  type        = string
  description = "Regiao da subnet publica"
}
