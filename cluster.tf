resource "google_container_cluster" "prod_cluster" {
  name             = "prod-cluster"
  location         = "europe-west1"
  enable_autopilot = true

  ip_allocation_policy {} # See https://github.com/hashicorp/terraform-provider-google/issues/10782
}

data "google_client_config" "provider" {}

locals {
  cluster_host           = "https://${google_container_cluster.prod_cluster.endpoint}"
  cluster_token          = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.prod_cluster.master_auth[0].cluster_ca_certificate)
}
