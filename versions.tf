terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.26.0"
    }
  }
}
