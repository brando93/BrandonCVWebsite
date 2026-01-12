#!/bin/bash
set -e

echo "Importing existing AWS resources into Terraform state..."

# Import S3 buckets
echo "Importing S3 buckets..."
terraform import aws_s3_bucket.dev bran-website-dev
terraform import aws_s3_bucket.prod bran-website-prod

# Import website configurations
echo "Importing website configurations..."
terraform import aws_s3_bucket_website_configuration.dev bran-website-dev
terraform import aws_s3_bucket_website_configuration.prod bran-website-prod

# Import public access blocks
echo "Importing public access blocks..."
terraform import aws_s3_bucket_public_access_block.dev bran-website-dev
terraform import aws_s3_bucket_public_access_block.prod bran-website-prod

# Import bucket policies
echo "Importing bucket policies..."
terraform import aws_s3_bucket_policy.dev bran-website-dev
terraform import aws_s3_bucket_policy.prod bran-website-prod

# Import versioning configurations
echo "Importing versioning configurations..."
terraform import aws_s3_bucket_versioning.dev bran-website-dev
terraform import aws_s3_bucket_versioning.prod bran-website-prod

echo ""
echo "✅ All resources imported successfully!"
echo "State is now stored in S3: s3://bran-terraform-state/terraform.tfstate"
echo ""
echo "Run 'terraform plan' to verify everything is in sync."

# Made with Bob
