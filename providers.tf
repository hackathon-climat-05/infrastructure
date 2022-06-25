provider "google" {
  project = "hackathon-climat-05"
}

provider "kubernetes" {
  host = local.cluster_host

  client_certificate     = local.cluster_client_certificate
  client_key             = local.cluster_client_key
  cluster_ca_certificate = local.cluster_ca_certificate
}
