locals {
  common_name = "${var.layer}-${var.component_name}-${var.stack_id}"

  common_tags = {
    Project     = "${var.layer}-${var.component_name}"
    Environment = var.stack_id
    Source      = "Terraform"
  }
}