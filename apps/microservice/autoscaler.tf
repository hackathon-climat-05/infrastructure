resource "kubernetes_horizontal_pod_autoscaler" "autoscaler" {
  metadata {
    name      = "${var.name}-autoscaler"
    namespace = var.namespace
  }

  spec {
    scale_target_ref {
      kind = "Deployment"
      name = kubernetes_deployment.microservice.metadata[0].name
    }

    min_replicas = 1
    max_replicas = var.env == "prod" ? 5 : 2

    metric {
      type = "Resource"

      resource {
        name = "cpu"

        target {
          type                = "Utilization"
          average_utilization = 50
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      spec.0.behavior
    ]
  }
}
