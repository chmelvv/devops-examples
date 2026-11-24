# Expose the instance public IP to the root module
output "public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web.public_ip
}

# Expose the formatted HTTP URL to the root module
output "web_url" {
  description = "HTTP URL of the web server"
  value       = "http://${aws_instance.web.public_ip}"
}