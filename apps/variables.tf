variable "env" {
  type        = string
  description = "The environment in which the apps should run (prod/stg)."
}

variable "domains" {
  type        = list(string)
  description = "The list of FQDN on which the apps should be accessible."
}
