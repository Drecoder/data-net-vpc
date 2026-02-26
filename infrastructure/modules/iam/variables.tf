variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

# Optional: allow custom service account name
variable "service_account_name" {
  type    = string
  default = "demo-service-account"
}

# Optional: assign roles
variable "roles" {
  type = list(string)
  default = [
    "roles/run.invoker",
    "roles/logging.logWriter"
  ]
}