resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "root_domain" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution
    zone_id                = var.hosted_zone_id
    evaluate_target_health = false
  }
}
