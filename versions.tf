terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.26.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.4.0"
    }

    flux = {
      source  = "fluxcd/flux"
      version = "~> 0.15.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }

    git = {
      source  = "arl-sh/git"
      version = "~> 0.3.0"
    }
  }
}
