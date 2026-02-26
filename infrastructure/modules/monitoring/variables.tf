# Project and environment info
variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

# Cloud Run service name to monitor
variable "cloud_run_service_name" {
  type        = string
  description = "The Cloud Run service to attach monitoring alerts to"
}

# Optional: email to receive alerts
variable "notification_email" {
  type        = string
  default     = null
  description = "Email address to receive alert notifications"
}

# Alert thresholds
variable "cpu_threshold" {
  type        = number
  default     = 80
  description = "CPU utilization % to trigger an alert"
}

variable "memory_threshold" {
  type        = number
  default     = 80
  description = "Memory utilization % to trigger an alert"
}

variable "cloud_run_service_id" {
  description = "ID of the Cloud Run service to wait for before creating alerts"
  type        = string
}