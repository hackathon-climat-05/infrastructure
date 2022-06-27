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
      "kubernetes.io/ingress.class" = "gce"
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
