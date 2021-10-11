# configura los proveedores, en este caso solo AWS
provider "aws" {
  region     = var.region
  access_key = var.user_information.access_key
  secret_key = var.user_information.secret_key
}

module "acm_certificate_website" {
    source = "./modules/security/acm_certificate"

    stack_id           = var.stack_id
    domain_name        = var.domain_name
}  

# Cloudfront
  module "cloudfront-website" {
    source = "./modules/cloudFrontS3"

    bucket_name                = "front"
    component_name             = var.component_name
    layer                      = var.layer
    stack_id                   = var.stack_id 
    path_name_content          = var.path_name_content
    path_name_back             = var.path_name_back
    web_acl_id                 = ""
    # custom origins
    alb_dns_name               = ""
    bucket_content_domain_name = ""  
    # custom certificate
    acm_certificate_arn        = module.acm_certificate_website.acm_certificate_arn
    aliases                    = var.aliases
}    

# Route 53
module "dns-website" {
    source = "./modules/route53"
    name                           = "DNS"
    layer                          = var.layer
    stack_id                       = var.stack_id
    domain_name                    = var.domain_name
    cloudfront_distribution        = module.cloudfront-website.s3_distribution.domain_name
    hosted_zone_id                 = module.cloudfront-website.s3_distribution.hosted_zone_id
    s3_distribution                = module.cloudfront-website.s3_distribution
    use_default_domain             = true
} 



