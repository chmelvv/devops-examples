output "instance_public_ip" {
  description = "Public IP address of the EC2 instance (for SSH connection)"
  value       = aws_instance.web_server.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance (Put this in the Kubernetes Endpoints manifest)"
  value       = aws_instance.web_server.private_ip
}