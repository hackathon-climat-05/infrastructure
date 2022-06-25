terraform {
  cloud {
    organization = "hackathon-climat-05"

    workspaces {
      name = "infrastructure"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.26.0"
    }
  }
}
