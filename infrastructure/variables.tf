variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "GCP region to deploy resources"
}

variable "environment" {
  type        = string
  description = "Environment name, e.g., dev or prod"
}

variable "cloud_run_service_name" {
  type        = string
  description = "Name of the Cloud Run service to monitor"
}

variable "cpu_threshold" {
  type        = number
  description = "CPU utilization threshold (%) to trigger alert"
}

variable "memory_threshold" {
  type        = number
  description = "Memory utilization threshold (%) to trigger alert"
}

variable "notification_email" {
  type        = string
  default     = null
  description = "Optional email address for alert notifications"
}

variable "cloud_run_service_id" {
  description = "ID of the Cloud Run service to wait for before creating alerts"
  type        = string
}

variable "logs_archive_bucket" {
  description = "Name of the central logs archive bucket for audit logging"
  type        = string
}