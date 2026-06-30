resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  wait       = true 

  values = [
    yamlencode({
      server = {
        service = {
          type = "LoadBalancer"
        }
      }
      configs = {
        repositories = {
          devops-examples = {
            url = var.gitops_repo_url
          }
        }
      }
    })
  ]
}

# Create the Argo CD Application object to track the specific subdirectory
resource "kubernetes_manifest" "argocd_application" {
  depends_on = [helm_release.argocd]

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "static-simple-site"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.gitops_repo_url
        targetRevision = "HEAD"
        path           = var.gitops_repo_path # where our app deployment.yaml exists
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default" 
      }
      syncPolicy = {
        automated = { #automated sync policy to automatically apply changes from the Git repository
          prune    = true #auto cleaning of resources that are no longer defined in the Git repository
          selfHeal = true #autofix cluster resources 
        }
      }
    }
  }
}