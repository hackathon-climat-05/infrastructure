variable "name" {
  type        = string
  description = "The name of the microservice to deploy."
}

variable "image_tag" {
  type        = string
  description = "The tag of the Docker image to deploy."
}

variable "env" {
  type        = string
  description = "The environment in which the microservice should run (prod/stg)."
}

variable "namespace" {
  type        = string
  description = "The namespace in which the microservice should be deployed."
}

variable "db_credentials_secret" {
  type        = string
  description = "The name of the secret in which are stored the database credentials."
}
