variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used in resource naming"
  type        = string
  default     = "bran-website"
}

variable "dev_bucket_name" {
  description = "S3 bucket name for development environment"
  type        = string
  default     = "bran-website-dev"
}

variable "prod_bucket_name" {
  description = "S3 bucket name for production environment"
  type        = string
  default     = "bran-website-prod"
}