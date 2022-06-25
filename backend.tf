resource "random_id" "bucket-id" {
  byte_length = 8
}

resource "google_storage_bucket" "tf-state-bucket" {
  name          = "terraform-state-${random_id.bucket-id.hex}"
  location      = "EUROPE-NORTH1+EUROPE-WEST1"
  force_destroy = true

  versioning {
    enabled = true
  }
}

output "tf_state_bucket_name" {
  value = google_storage_bucket.tf-state-bucket.name
}

terraform {
  backend "gcs" {
    bucket = "terraform-state-d4d42155847b8244"
  }
}
