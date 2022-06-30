module "prod_apps" {
  source = "./apps"

  env = "prod"

  domains = [
    "greenmile.app",
    "greenmile.earth",
    "greenmile.cloud",
    "www.greenmile.app",
    "www.greenmile.earth",
    "www.greenmile.cloud"
  ]

  google_client_id     = var.google_client_id
  google_client_secret = var.google_client_secret
}

module "stg_apps" {
  source = "./apps"

  env = "stg"

  domains = [
    "stg.greenmile.app",
    "stg.greenmile.earth",
    "stg.greenmile.cloud",
    "www.stg.greenmile.app",
    "www.stg.greenmile.earth",
    "www.stg.greenmile.cloud"
  ]

  google_client_id     = var.google_client_id
  google_client_secret = var.google_client_secret
}
