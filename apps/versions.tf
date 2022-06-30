locals {
  versions = {
    prod = {
      front      = "v1.0.1"
      auth       = "v1.0.1"
      calculator = "v1.0.1"
      data       = "v1.0.1"
      challenges = "v1.0.1"
    }

    stg = {
      front      = "stg-latest"
      auth       = "stg-latest"
      calculator = "stg-latest"
      data       = "stg-latest"
      challenges = "stg-latest"
    }
  }
}
