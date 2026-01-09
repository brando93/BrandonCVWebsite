output "dev_website_endpoint" {
  description = "Website endpoint for DEV environment"
  value       = aws_s3_bucket_website_configuration.dev.website_endpoint
}

output "dev_website_url" {
  description = "Full website URL for DEV environment"
  value       = "http://${aws_s3_bucket_website_configuration.dev.website_endpoint}"
}

output "prod_website_endpoint" {
  description = "Website endpoint for PROD environment"
  value       = aws_s3_bucket_website_configuration.prod.website_endpoint
}

output "prod_website_url" {
  description = "Full website URL for PROD environment"
  value       = "http://${aws_s3_bucket_website_configuration.prod.website_endpoint}"
}

output "dev_bucket_name" {
  description = "Name of the DEV S3 bucket"
  value       = aws_s3_bucket.dev.id
}

output "prod_bucket_name" {
  description = "Name of the PROD S3 bucket"
  value       = aws_s3_bucket.prod.id
}
