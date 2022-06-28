resource "random_password" "mariadb_root_password" {
  length  = 16
  special = true
}

resource "random_password" "mariadb_user_password" {
  length  = 16
  special = true
}

resource "random_password" "mariadb_backup_password" {
  length  = 16
  special = true
}

resource "helm_release" "mariadb" {
  name      = "mariadb"
  namespace = kubernetes_namespace.namespace.metadata[0].name

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mariadb-galera"
  version    = "7.3.5"

  timeout = 15 * 60

  values = [
    yamlencode({
      rootUser = {
        forcePassword = true
      }

      db = {
        name          = "greenmile"
        user          = "greenmile"
        forcePassword = true
      }

      galera = {
        mariabackup = {
          user          = "mariabackup"
          forcePassword = true
        }
      }
    })
  ]

  set_sensitive {
    name  = "rootUser.password"
    value = random_password.mariadb_root_password.result
  }

  set_sensitive {
    name  = "db.password"
    value = random_password.mariadb_user_password.result
  }

  set_sensitive {
    name  = "galera.mariabackup.password"
    value = random_password.mariadb_backup_password.result
  }

  lifecycle {
    ignore_changes = [
      metadata[0]
    ]
  }
}

locals {
  mariadb_config = yamldecode(helm_release.mariadb.values[0])

  mariadb_host     = "${helm_release.mariadb.name}-${helm_release.mariadb.chart}"
  mariadb_port     = 3306
  mariadb_user     = local.mariadb_config.db.user
  mariadb_password = random_password.mariadb_user_password.result
  mariadb_database = local.mariadb_config.db.name
}

output "mariadb_root_password" {
  value     = random_password.mariadb_root_password.result
  sensitive = true
}

output "mariadb_backup_password" {
  value     = random_password.mariadb_backup_password.result
  sensitive = true
}
