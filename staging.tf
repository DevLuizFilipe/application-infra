#Cria um bucket para o site estático
module "bucket_website_staging" {
  source         = "./modules/s3/"
  s3_bucket_name = "lab-application-staging"
  s3_site_index  = "index.html"
  s3_site_error  = "error.html"
}

#Cria uma role para o ECS
module "ecs_iam_staging" {
  source            = "./modules/iam/"
  iam_ecs_role_name = "iam-ecs-staging"
}

#Cria um cluster ECS
module "ecs_staging" {
  source           = "./modules/ecs/"
  ecs_cluster_name = "application-staging"
}

#Cria uma task definition ECS
module "application_staging" {
  source                       = "./modules/ecs_task/"
  ecs_task_family              = "application-staging"
  ecs_task_role_arn            = module.ecs_iam_staging.ecs_role_arn
  ecs_task_compatibilities     = ["FARGATE"]
  ecs_task_container_name      = "application-staging"
  ecs_task_container_image     = "luizfilipesm/waycarbon"
  ecs_task_container_image_tag = "latest"
  ecs_task_container_port      = "80"
  ecs_task_port                = module.application_staging.task_container_port
  ecs_task_memory              = "512"
  ecs_task_cpu                 = "256"
  depends_on                   = [module.ecs_iam_staging]
}

#Cria uma VPC com duas subnetes privadas que utiliza um NAT gateway e uma publica que utiliza um internet gateway
module "vpc_staging" {
  source                   = "./modules/vpc/"
  vpc_name                 = "vpc-application-staging"
  vpc_cidr_block           = "10.0.0.0/16"
  vpc_subnet_private_count = "2"
  vpc_subnet_public_count  = "2"
  vpc_subnet_regions       = "us-east-1a,us-east-1b"
}

#Cria um load balancer, um listener e um target group
module "elb_staging" {
  source                               = "./modules/elb/"
  elb_name                             = "elb-application-staging"
  elb_type                             = "application"
  elb_subnets                          = module.vpc_staging.subnet_public_id
  elb_security_groups                  = [module.vpc_staging.security_group_id_elb]
  elb_target_group_name                = "application-staging"
  elb_target_group_port                = module.application_staging.task_container_port
  elb_target_group_protocol            = "HTTP"
  elb_target_group_vpc                 = module.vpc_staging.vpc_id
  elb_group_target_heatlh_interval     = "10"
  elb_group_target_heatlh_path         = "/api"
  elb_group_target_heatlh_timeout      = "5"
  elb_group_target_heatlh_threshold    = "3"
  elb_group_target_unhealthy_threshold = "2"
  elb_listener_port_http               = "80"
  elb_listener_protocol_http           = "HTTP"
  depends_on                           = [module.vpc_staging]
}

#Cria um service ECS
module "application_service_staging" {
  source                       = "./modules/ecs_service/"
  ecs_service_name             = "application-staging"
  ecs_service_cluster          = module.ecs_staging.cluster_name
  ecs_service_task             = module.application_staging.task_arn
  ecs_service_count            = "1"
  ecs_service_type             = "FARGATE"
  ecs_service_target_group_arn = module.elb_staging.target_group_arn
  ecs_service_container_name   = module.application_staging.task_container_name
  ecs_service_container_port   = module.application_staging.task_container_port
  ecs_service_subnets          = module.vpc_staging.subnet_private_id
  ecs_service_security_groups  = [module.vpc_staging.security_group_id_ecs]
  depends_on                   = [module.application_staging, module.ecs_staging, module.bucket_website_staging, module.cdn_staging]
}

#Cria um CDN para a aplicação
module "cdn_staging" {
  source                  = "./modules/cdn/"
  cdn_damin_name          = module.elb_staging.dns_name
  cdn_origin_id           = module.elb_staging.elb_name
  cdn_enabled             = "true"
  cdn_ipv6                = "true"
  cdn_allowed_methods     = ["GET", "HEAD", "OPTIONS"]
  cdn_cached_methods      = ["GET", "HEAD", "OPTIONS"]
  cdn_cache_target_origin = module.elb_staging.elb_name
  cdn_query_string        = "false"
  cdn_cookies             = "none"
  cdn_protocol_policy     = "redirect-to-https"
  cdn_min_ttl             = "0"
  cdn_default_ttl         = "3600"
  cdn_max_ttl             = "86400"
  cdn_geo_restriction     = "none"
  cdn_certificate_default = "true"
  cdn_target_path         = "/api"
  depends_on              = [module.elb_staging]
}

# #Cria um dominio e um record do tipo CNAME
# module "route53" {
#   source              = "./modules/route53/"
#   route53_zone_name   = "labluizfilipe.com.br"
#   route53_record_name = "application-teste"
#   route53_record_type = "CNAME"
#   route53_record_ttl  = "15"
#   route53_records     = [""] #Alterar
# }

output "frontend_url_staging" {
  value       = module.bucket_website_staging.domain_name
  description = "URL do frontend"
}

output "backend_url_staging" {
  value       = module.cdn_staging.cloudfront_domain_name
  description = "Dominio do CloudFront"
}
