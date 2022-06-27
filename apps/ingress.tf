resource "kubernetes_manifest" "app_ssl_certificate" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "ManagedCertificate"

    metadata = {
      name      = "app-ssl-certificate"
      namespace = kubernetes_namespace.namespace.metadata[0].name
    }

    spec = {
      domains = var.domains
    }
  }
}

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "app-ingress"
    namespace = kubernetes_namespace.namespace.metadata[0].name

    labels = {
      app  = "greenmile"
      side = "frontend"
      env  = var.env
    }

    annotations = {
      "kubernetes.io/ingress.class"            = "gce"
      "networking.gke.io/managed-certificates" = kubernetes_manifest.app_ssl_certificate.manifest.metadata.name
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/*"

          backend {
            service {
              name = kubernetes_service.front.metadata[0].name

              port {
                name = "http"
              }
            }
          }
        }
      }
    }
  }
}
