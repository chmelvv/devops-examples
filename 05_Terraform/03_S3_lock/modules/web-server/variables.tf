# EC2 instance size
variable "instance_type" {
  description = "EC2 instance type for the web server"
  type        = string
  default     = "t3.micro"
}

# Environment identifier (e.g., Dev, Stage, Prod)
variable "env_name" {
  description = "Environment name used for resource naming and tagging"
  type        = string
}

# Custom HTML body rendered on the index page
variable "web_content" {
  description = "HTML content written to /var/www/html/index.html"
  type        = string
}