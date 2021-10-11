variable "name"   { }
variable "domain_name" { default     = "" }
variable "hosted_zone_id" { default     = "" }
variable "use_default_domain" { default     = false }
variable "layer" {
  description = "A unique identifier for the deployment. Used as a prefix for all the Openstack resources."
  type        = string
}

variable "stack_id" {
  description = "A unique identifier for the deployment. Used as a prefix for all the Openstack resources."
  type        = string
}

variable "s3_distribution" {}

variable  "cloudfront_distribution" {}