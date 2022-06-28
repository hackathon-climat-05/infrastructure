resource "kubernetes_deployment" "microservice" {
  metadata {
    name      = "${var.name}-microservice"
    namespace = var.namespace

    labels = {
      app          = "greenmile"
      side         = "backend"
      microservice = var.name
      env          = var.env
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app          = "greenmile"
        side         = "backend"
        microservice = var.name
        env          = var.env
      }
    }

    template {
      metadata {
        labels = {
          app          = "greenmile"
          side         = "backend"
          microservice = var.name
          env          = var.env
        }
      }

      spec {
        container {
          image             = "ghcr.io/hackathon-climat-05/${var.name}-microservice:${var.image_tag}"
          image_pull_policy = "Always"
          name              = "${var.name}-microservice"

          port {
            name           = "http"
            container_port = 8080
          }

          dynamic "env" {
            for_each = ["host", "port", "user", "password", "database"]

            content {
              name = "DB_${replace(upper(env.value), "-", "_")}"

              value_from {
                secret_key_ref {
                  name = var.db_credentials_secret
                  key  = env.value
                }
              }
            }
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
              path = "/livez"
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
