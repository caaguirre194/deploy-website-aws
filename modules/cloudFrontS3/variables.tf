variable "layer" {
  description = "A unique identifier for the deployment. Used as a prefix for all the Openstack resources."
  type        = string
}

variable "stack_id" {
  description = "A unique identifier for the deployment. Used as a prefix for all the Openstack resources."
  type        = string
}

variable "component_name" {
  description = "Nombre del componente"
  type        = string
}

variable "bucket_name" {
  description = "Name bucket multimedia s3"
  type        = string
}

variable "web_acl_id" {
  description = "WAF ACL rule id"
  type        = string
}

variable "alb_dns_name" {
  type = string
}

variable "path_name_back" {
  type = string
}

variable "path_name_content" {
  type = string
}

variable "bucket_content_domain_name" {
  type = string
}

variable "acm_certificate_arn" { 
  type = string
}

variable "aliases" {
  type    = list(string)
}