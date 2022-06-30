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
    replicas = 1

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

          env {
            name = "JWT_SECRET"

            value_from {
              secret_key_ref {
                name = var.jwt_secret
                key  = "jwt_secret"
              }
            }
          }

          dynamic "env" {
            for_each = ["client_id", "client_secret", "redirect_url"]

            content {
              name = "GOOGLE_${replace(upper(env.value), "-", "_")}"

              value_from {
                secret_key_ref {
                  name = var.google_credentials_secret
                  key  = env.value
                }
              }
            }
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
              cpu    = "1"
              memory = "2Gi"
            }

            limits = {
              cpu    = "1"
              memory = "2Gi"
            }
          }

          liveness_probe {
            http_get {
              path = "/livez"
              port = 8080
            }

            initial_delay_seconds = 10
            period_seconds        = 15
            failure_threshold     = 10
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
