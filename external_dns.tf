# apiVersion: v1
# kind: ServiceAccount
# metadata:
#   name: external-dns
#   labels:
#     app.kubernetes.io/name: external-dns
# ---
# apiVersion: rbac.authorization.k8s.io/v1
# kind: ClusterRole
# metadata:
#   name: external-dns
#   labels:
#     app.kubernetes.io/name: external-dns
# rules:
#   - apiGroups: [""]
#     resources: ["services","endpoints","pods","nodes"]
#     verbs: ["get","watch","list"]
#   - apiGroups: ["extensions","networking.k8s.io"]
#     resources: ["ingresses"]
#     verbs: ["get","watch","list"]
# ---
# apiVersion: rbac.authorization.k8s.io/v1
# kind: ClusterRoleBinding
# metadata:
#   name: external-dns-viewer
#   labels:
#     app.kubernetes.io/name: external-dns
# roleRef:
#   apiGroup: rbac.authorization.k8s.io
#   kind: ClusterRole
#   name: external-dns
# subjects:
#   - kind: ServiceAccount
#     name: external-dns
#     namespace: default # change if namespace is not 'default'

resource "kubernetes_namespace" "external_dns_namespace" {
  metadata {
    name = "external-dns"

    labels = {
      app = "external-dns"
    }
  }
}

resource "kubernetes_deployment" "external_dns" {
  metadata {
    name      = "external-dns"
    namespace = kubernetes_namespace.external_dns_namespace.metadata[0].name

    labels = {
      app = "external-dns"
    }
  }

  spec {
    strategy {
      type = "Recreate"
    }

    selector {
      match_labels = {
        app = "external-dns"
      }
    }

    template {
      metadata {
        labels = {
          app = "external-dns"
        }
      }

      spec {
        # service_account_name = "external-dns"

        container {
          name              = "external-dns"
          image             = "registry.opensource.zalan.do/teapot/external-dns:latest"
          image_pull_policy = "Always"

          args = [
            "--source=ingress",
            "--provider=google",
            "--policy=upsert-only",
            "--registry=txt",
            "--txt-owner-id=greenmile-prod-cluster"
          ]
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
      spec.0.template.0.spec.0.container.0.resources.0.limits,
      spec.0.template.0.spec.0.container.0.resources.0.requests,
      spec.0.template.0.spec.0.container.0.security_context,
      spec.0.template.0.spec.0.security_context
    ]
  }
}
