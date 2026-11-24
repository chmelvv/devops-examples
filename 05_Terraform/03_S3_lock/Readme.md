Join together modular project + 
  save Remote State in AWS S3

terraform init
terraform apply

uncomment Dev, Stage servers + backend.tf

terraform init -migrate-state
terraform plan
terraform apply

Questions:
- Why do not save terraform.tfstate just in Git?




