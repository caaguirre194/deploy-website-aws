output "s3_reference" {
  value = aws_s3_bucket.s3
}
output "s3_distribution" {
  value = aws_cloudfront_distribution.s3_distribution
}
output "arn_cloudfront_identity_arn" {
  value = aws_cloudfront_origin_access_identity.s3_identity.iam_arn 
}

output "bucknet-name" {
  value = aws_s3_bucket.s3.bucket
}