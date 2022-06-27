locals {
  versions = {
    prod = {
      front      = "v0.0.1"
      auth       = "v0.0.1"
      calculator = "v0.0.1"
      data       = "v0.0.1"
      challenges = "v0.0.1"
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
