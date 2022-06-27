resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "greenmile-${var.env}"

    labels = {
      app = "greenmile"
      env = var.env
    }
  }
}
