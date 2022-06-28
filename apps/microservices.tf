module "auth_microservice" {
  source = "./microservice"

  name                  = "auth"
  image_tag             = local.versions[var.env].auth
  env                   = var.env
  namespace             = kubernetes_namespace.namespace.metadata[0].name
  db_credentials_secret = kubernetes_secret.mariadb_credentials.metadata[0].name
}

module "calculator_microservice" {
  source = "./microservice"

  name                  = "calculator"
  image_tag             = local.versions[var.env].calculator
  env                   = var.env
  namespace             = kubernetes_namespace.namespace.metadata[0].name
  db_credentials_secret = kubernetes_secret.mariadb_credentials.metadata[0].name
}

module "data_microservice" {
  source = "./microservice"

  name                  = "data"
  image_tag             = local.versions[var.env].data
  env                   = var.env
  namespace             = kubernetes_namespace.namespace.metadata[0].name
  db_credentials_secret = kubernetes_secret.mariadb_credentials.metadata[0].name
}

module "challenges_microservice" {
  source = "./microservice"

  name                  = "challenges"
  image_tag             = local.versions[var.env].challenges
  env                   = var.env
  namespace             = kubernetes_namespace.namespace.metadata[0].name
  db_credentials_secret = kubernetes_secret.mariadb_credentials.metadata[0].name
}
