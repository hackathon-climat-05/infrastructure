resource "google_container_cluster" "prod_cluster" {
  name             = "prod-cluster"
  location         = "europe-west1"
  enable_autopilot = true

  ip_allocation_policy {} # See https://github.com/hashicorp/terraform-provider-google/issues/10782
}

locals {
  cluster_host = google_container_cluster.prod_cluster

  cluster_client_certificate = google_container_cluster.prod_cluster.master_auth.0.client_certificate
  cluster_client_key         = google_container_cluster.prod_cluster.master_auth.0.client_key
  cluster_ca_certificate     = google_container_cluster.prod_cluster.master_auth.0.cluster_ca_certificate
}
