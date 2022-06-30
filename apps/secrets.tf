resource "random_password" "jwt_secret" {
  length  = 64
  special = false
}

resource "kubernetes_secret" "jwt_secret" {
  metadata {
    name      = "jwt-secret"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  data = {
    jwt_secret = random_password.jwt_secret.result
  }
}

resource "kubernetes_secret" "google_credentials" {
  metadata {
    name      = "google-credentials"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  data = {
    client_id     = var.google_client_id
    client_secret = var.google_client_secret
    redirect_url  = "https://greenmile.app/google_callback"
  }
}

resource "kubernetes_secret" "mariadb_credentials" {
  metadata {
    name      = "mariadb-credentials"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  data = {
    host     = local.mariadb_host
    port     = local.mariadb_port
    user     = local.mariadb_user
    password = local.mariadb_password
    database = local.mariadb_database
  }
}
