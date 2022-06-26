resource "google_container_cluster" "prod_cluster" {
  name             = "prod-cluster"
  location         = "europe-west1"
  enable_autopilot = true

  ip_allocation_policy {} # See https://github.com/hashicorp/terraform-provider-google/issues/10782
}

module "gke_auth" {
  source       = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  project_id   = google_container_cluster.prod_cluster.project
  cluster_name = google_container_cluster.prod_cluster.name
  location     = google_container_cluster.prod_cluster.location
}

locals {
  cluster_host           = module.gke_auth.host
  cluster_token          = module.gke_auth.token
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
}
