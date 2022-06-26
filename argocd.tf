resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name      = "argo-cd"
  namespace = kubernetes_namespace.argocd_namespace.metadata[0].name

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.9.7"

  values = [
    yamlencode({
      redis-ha = {
        enabled = true
      }

      controller = {
        enableStatefulSet = true
      }

      server = {
        autoscaling = {
          enabled     = true
          minReplicas = 2
        }
      }

      repoServer = {
        autoscaling = {
          enabled     = true
          minReplicas = 2
        }
      }
    })
  ]
}
