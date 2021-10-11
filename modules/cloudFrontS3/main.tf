resource "aws_cloudfront_origin_access_identity" "s3_identity" {
  comment = "Identity-${local.common_name}-${var.bucket_name}"
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_bucket" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket" "s3" {
  bucket = "${local.common_name}-${var.bucket_name}"
  acl    = "private"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name}-${var.bucket_name}"
    }
  )

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {

  origin {
    domain_name = aws_s3_bucket.s3.bucket_regional_domain_name
    origin_id   = "s3-${aws_s3_bucket.s3.bucket}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_identity.cloudfront_access_identity_path
    }
  }

  viewer_certificate {
    # cloudfront_default_certificate = true
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = "sni-only"
  } 

  aliases         = var.aliases
  enabled         = true
  is_ipv6_enabled = false
  comment         = "${local.common_name}-${var.bucket_name}"
  
  
  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "s3-${aws_s3_bucket.s3.bucket}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    compress    = true
    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name}-${var.bucket_name}"
    }
  )

  web_acl_id = var.web_acl_id
}