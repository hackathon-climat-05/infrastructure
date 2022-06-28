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
