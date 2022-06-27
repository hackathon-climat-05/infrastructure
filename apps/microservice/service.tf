resource "kubernetes_service" "service" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    selector = kubernetes_deployment.microservice.spec[0].selector[0].match_labels

    session_affinity = "ClientIP"

    port {
      name        = "http"
      port        = 80
      target_port = "http"
    }

    type = "ClusterIP"
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations
    ]
  }
}
