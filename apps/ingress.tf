resource "kubernetes_ingress" "app_ingress" {
  metadata {
    name      = "app-ingress"
    namespace = kubernetes_namespace.namespace.metadata[0].name

    labels = {
      app  = "greenmile"
      side = "frontend"
      env  = var.env
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/*"

          backend {
            service_name = kubernetes_service.front.metadata[0].name
            service_port = "http"
          }
        }
      }
    }
  }
}
