provider "google" {
  project = "hackathon-climat-05"
}

provider "kubernetes" {
  host                   = local.cluster_host
  token                  = local.cluster_token
  cluster_ca_certificate = local.cluster_ca_certificate
}

provider "kubectl" {
  host                   = local.cluster_host
  token                  = local.cluster_token
  cluster_ca_certificate = local.cluster_ca_certificate
  load_config_file       = false
}
