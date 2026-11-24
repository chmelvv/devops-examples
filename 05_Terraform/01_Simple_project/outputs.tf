# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web.public_ip
}

# Output the ready-to-use HTTP URL
output "web_server_url" {
  description = "URL to access the deployed web server"
  value       = "http://${aws_instance.web.public_ip}"
}