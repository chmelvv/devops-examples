# Create an S3 bucket to store remote Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  # Allow Terraform to delete the bucket even if state file versions exist (useful for labs)
  force_destroy = true

  tags = {
    Name    = "Terraform State Bucket"
    Project = var.project_name
  }
}

# Enable versioning so every state update is preserved for recovery
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable default server-side encryption (AES-256) for state security
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access to the state bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}