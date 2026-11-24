# S3 Remote State Locking Module

Provisions an encrypted, versioned AWS S3 bucket for storing and locking Terraform remote state.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `bucket_name` | Globally unique S3 bucket name | `string` | n/a | yes |
| `project_name` | Project tag value | `string` | `"devops-iac-lab"` | no |

## Outputs

| Name | Description |
|------|-------------|
| `s3_bucket_name` | Name of the created S3 bucket |