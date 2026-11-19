variable "cluster_name" {
  type        = string
  description = "The name of the target AWS EKS cluster"
  default     = "devops-eks-cluster"
}

variable "argocd_version" {
  type        = string
  description = "The Helm chart version for Argo CD"
  default     = "6.7.11"
}

variable "gitops_repo_url" {
  type        = string
  description = "The URL of the GitOps repository for tracking manifests"
  default     = "https://github.com/chmelvv/devops-examples.git"
}

variable "gitops_repo_path" {
  type        = string
  description = "The path within the GitOps repository where the deployment manifests are located"
  default     = "gitops-repo/app"
}