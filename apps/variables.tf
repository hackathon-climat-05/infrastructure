variable "env" {
  type        = string
  description = "The environment in which the apps should run (prod/stg)."
}

variable "domains" {
  type        = list(string)
  description = "The list of FQDN on which the apps should be accessible."
}

variable "google_client_id" {
  type        = string
  description = "The Client ID for Google's OAuth 2.0 credentials."
}

variable "google_client_secret" {
  type        = string
  description = "The Client secret for Google's OAuth 2.0 credentials."
}
