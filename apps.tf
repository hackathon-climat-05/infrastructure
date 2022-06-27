module "prod_apps" {
  source = "./apps"

  env = "prod"

  domains = [
    "greenmile.app",
    "greenmile.earth",
    "greenmile.cloud"
  ]
}

module "stg_apps" {
  source = "./apps"

  env = "stg"

  domains = [
    "stg.greenmile.app",
    "stg.greenmile.earth",
    "stg.greenmile.cloud"
  ]
}
