# #Cria um bucket para o site estático
# module "bucket_website" {
#   source         = "./modules/s3/"
#   s3_bucket_name = "lab-teste-tecnico-filipe"
#   s3_bucket_acl  = "public-read"
#   s3_site_index  = "index.html"
#   s3_site_error  = "error.html"
# }

#Cria uma role para o ECS
module "ecs_iam" {
  source            = "./modules/iam/"
  iam_ecs_role_name = "iam-ecs"
}

#Cria um cluster ECS
module "ecs" {
  source           = "./modules/ecs/"
  ecs_cluster_name = "waycarbon"
}

#Cria uma task definition ECS
module "application" {
  source                   = "./modules/ecs_task/"
  ecs_task_family          = "waycarbon"
  ecs_task_role_arn        = module.ecs_iam.ecs_role_arn
  ecs_task_compatibilities = ["FARGATE"]
  ecs_task_container_name  = "application"
  ecs_task_container_image = "luizfilipesm/waycarbon:latest"
  ecs_task_container_port  = "80"
  ecs_task_port            = module.application.task_container_port
  ecs_task_memory          = "512"
  ecs_task_cpu             = "256"
  depends_on               = [module.ecs_iam]
}

#Cria uma VPC com duas subnetes privadas que utiliza um NAT gateway e uma publica que utiliza um internet gateway
module "vpc" {
  source                                   = "./modules/vpc/"
  vpc_name                                 = "vpc-waycarbon"
  vpc_cidr_block                           = "10.0.0.0/16"
  vpc_subnet_private_count                 = "2"
  vpc_subnet_public_count                  = "2"
  vpc_security_group_ingress_from_port_elb = "80"
  vpc_security_group_ingress_to_port_elb   = "80"
  vpc_subnet_private_cidr_block_base       = "10.0.0.0/12"
  vpc_subnet_private_cidr_block_bits       = "12"
  vpc_subnet_public_cidr_block_base        = "10.0.1.0/12"
  vpc_subnet_public_cidr_block_bits        = "12"
  vpc_subnet_private_region                = "us-east-1a"
  vpc_subnet_public_region                 = "us-east-1b"
}

#Cria um load balancer
module "elb" {
  source                               = "./modules/elb/"
  elb_name                             = "elb-waycarbon"
  elb_type                             = "application"
  elb_subnets                          = module.vpc.subnet_public_id
  elb_security_groups                  = [module.vpc.security_group_id_elb]
  elb_target_group_name                = "ecs-waycarbon-target-group"
  elb_target_group_port                = module.application.task_container_port
  elb_target_group_protocol            = "HTTP"
  elb_target_group_vpc                 = module.vpc.vpc_id
  elb_group_target_heatlh_interval     = "10"
  elb_group_target_heatlh_path         = "/"
  elb_group_target_heatlh_timeout      = "5"
  elb_group_target_heatlh_threshold    = "3"
  elb_group_target_unhealthy_threshold = "2"
  elb_listener_port_http               = "80"
  elb_listener_protocol_http           = "HTTP"
  depends_on                           = [module.vpc]
}

#Cria um service ECS
module "application_service" {
  source                       = "./modules/ecs_service/"
  ecs_service_name             = "waycarbon"
  ecs_service_cluster          = module.ecs.cluster_name
  ecs_service_task             = module.application.task_arn
  ecs_service_count            = "1"
  ecs_service_target_group_arn = module.elb.target_group_arn
  ecs_service_container_name   = module.application.task_container_name
  ecs_service_container_port   = module.application.task_container_port
  ecs_service_subnets          = module.vpc.subnet_private_id
  ecs_service_security_groups  = [module.vpc.security_group_id_ecs]
  depends_on                   = [module.vpc, module.application, module.ecs]
}

#Cria um CDN para a aplicação
# module "cdn" {
#   source                  = "./modules/cdn/"
#   cdn_damin_name          = module.bucket_website.domain_name
#   cdn_origin_id           = module.bucket_website.bucket_name
#   cdn_enabled             = "true"
#   cdn_ipv6                = "true"
#   cdn_root_object         = "index.html"
#   cdn_allowed_methods     = ["GET", "HEAD", "OPTIONS"]
#   cdn_cached_methods      = ["GET", "HEAD", "OPTIONS"]
#   cdn_cache_target_origin = module.bucket_website.bucket_name
#   cdn_query_string        = "false"
#   cdn_cookies             = "none"
#   cdn_protocol_policy     = "redirect-to-https"
#   cdn_min_ttl             = "0"
#   cdn_default_ttl         = "3600"
#   cdn_max_ttl             = "86400"
#   cdn_geo_restriction     = "none"
#   cdn_certificate_default = "true"
#   depends_on              = [module.bucket_website]
# }

# #Cria um dominio e um record do tipo CNAME
# module "route53" {
#   source              = "./modules/route53/"
#   route53_zone_name   = "labluizfilipe.com.br"
#   route53_record_name = "waycarbon-teste"
#   route53_record_type = "CNAME"
#   route53_record_ttl  = "15"
#   route53_records     = ["ad3f84cb53d294f9c80b2ee8465ac1d3-818998528.us-east-1.elb.amazonaws.com"] #Alterar
# }
