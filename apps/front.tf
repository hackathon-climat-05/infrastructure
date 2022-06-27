resource "kubernetes_deployment" "app_front" {
  metadata {
    name      = "app-front"
    namespace = kubernetes_namespace.namespace.metadata[0].name

    labels = {
      app  = "greenmile"
      side = "frontend"
      env  = var.env
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app  = "greenmile"
        side = "frontend"
        env  = var.env
      }
    }

    template {
      metadata {
        labels = {
          app  = "greenmile"
          side = "frontend"
          env  = var.env
        }
      }

      spec {
        container {
          image = "ghcr.io/hackathon-climat-05/app-front:${local.versions[var.env].front}"
          name  = "app-front"

          port {
            name           = "http"
            container_port = 8080
          }

          resources {
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }

            limits = {
              cpu    = "1"
              memory = "512Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/api/livez"
              port = 8080
            }

            initial_delay_seconds = 1
            period_seconds        = 1
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
      spec.0.template.0.spec.0.container.0.resources.0.limits,
      spec.0.template.0.spec.0.container.0.resources.0.requests,
      spec.0.template.0.spec.0.container.0.security_context,
      spec.0.template.0.spec.0.security_context
    ]
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "front_autoscaler" {
  metadata {
    name      = "front-autoscaler"
    namespace = kubernetes_namespace.namespace.metadata[0].name

    labels = {
      app  = "greenmile"
      side = "frontend"
      env  = var.env
    }
  }

  spec {
    scale_target_ref {
      kind = "Deployment"
      name = kubernetes_deployment.app_front.metadata[0].name
    }

    min_replicas = 2
    max_replicas = var.env == "prod" ? 10 : 5

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
}

resource "kubernetes_service" "front" {
  metadata {
    name      = "front"
    namespace = kubernetes_namespace.namespace.metadata[0].name

    labels = {
      app  = "greenmile"
      side = "frontend"
      env  = var.env
    }
  }

  spec {
    selector = kubernetes_deployment.app_front.spec[0].selector[0].match_labels

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
