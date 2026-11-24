# Output the URL for the Dev environment
output "dev_url" {
  description = "URL for the Development web server"
  value       = module.dev_server.web_url
}

# Output the URL for the Stage environment
output "stage_url" {
  description = "URL for the Staging web server"
  value       = module.stage_server.web_url
}