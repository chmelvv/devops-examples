# Output the created S3 bucket name
output "s3_bucket_name" {
  description = "Name of the S3 bucket storing Terraform state"
  value       = aws_s3_bucket.terraform_state.bucket
}