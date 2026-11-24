# Web Server Terraform Module

Deploys an Ubuntu 22.04 EC2 instance running Nginx with a dedicated Security Group (port 80 open) and custom HTML landing page.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `env_name` | Environment name (`Dev`, `Stage`, etc.) | `string` | n/a | yes |
| `web_content` | HTML content for `index.html` | `string` | n/a | yes |
| `instance_type` | EC2 instance type | `string` | `"t3.micro"` | no |

## Outputs

| Name | Description |
|------|-------------|
| `public_ip` | Public IP address of the EC2 instance |
| `web_url` | Full HTTP URL to access the web server |