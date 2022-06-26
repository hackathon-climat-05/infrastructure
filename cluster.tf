resource "google_container_cluster" "prod_cluster" {
  name             = "prod-cluster"
  location         = "europe-west1"
  enable_autopilot = true

  ip_allocation_policy {} # See https://github.com/hashicorp/terraform-provider-google/issues/10782
}

data "google_client_config" "provider" {}
data "google_client_openid_userinfo" "me" {}

resource "kubernetes_cluster_role_binding" "cluster_admin" {
  metadata {
    name = "google-service-account-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "User"
    api_group = "rbac.authorization.k8s.io"
    name      = data.google_client_openid_userinfo.me.email
  }
}

locals {
  cluster_host           = "https://${google_container_cluster.prod_cluster.endpoint}"
  cluster_token          = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.prod_cluster.master_auth[0].cluster_ca_certificate)
}
