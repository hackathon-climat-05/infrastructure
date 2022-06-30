locals {
  versions = {
    prod = {
      front      = "v1.0.0"
      auth       = "v1.0.0"
      calculator = "v1.0.0"
      data       = "v1.0.0"
      challenges = "v1.0.0"
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
