# Project & region info
variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

# Service account provided by IAM module
variable "service_account_email" {
  type        = string
  description = "Service account used by Cloud Run"
}

# Cloud Run scaling (optional)
variable "min_instances" {
  type    = number
  default = 0
}

variable "max_instances" {
  type    = number
  default = 3
}

# Optional: container image
variable "image" {
  type    = string
  default = "us-docker.pkg.dev/cloudrun/container/hello"
}

# Optional: environment variables
variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "invoker_sa" {
  description = "Service account allowed to invoke the Cloud Run service"
  type        = string
}

variable "logs_archive_bucket" {
  description = "Name of the central logs archive bucket for audit logging"
  type        = string
}