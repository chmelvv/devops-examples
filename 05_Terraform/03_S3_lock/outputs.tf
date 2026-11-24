# Output S3 backend details
output "state_bucket_name" {
  description = "S3 bucket name for remote state"
  value       = module.s3_backend.s3_bucket_name
}

# Output URLs for both web server environments
output "dev_server_url" {
  description = "HTTP URL for the Dev web server"
  value       = module.dev_server.web_url
}

output "stage_server_url" {
  description = "HTTP URL for the Stage web server"
  value       = module.stage_server.web_url
}