/*
# Notification channel (email)
resource "google_monitoring_notification_channel" "email" {
  count        = var.notification_email != null ? 1 : 0
  project      = var.project_id
  type         = "email"
  display_name = "${var.environment}-alert-email"

  labels = {
    email_address = var.notification_email
  }
}

# CPU alert policy
resource "google_monitoring_alert_policy" "cloud_run_cpu" {
  display_name = "${var.environment}-cloud-run-cpu-alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Cloud Run CPU High"

    condition_threshold {
      filter = <<-EOT
        resource.type="cloud_run_revision"
        AND metric.type="run.googleapis.com/revision/cpu/utilization"
        AND resource.label."service_name"="${var.cloud_run_service_name}"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = var.cpu_threshold / 100
      duration        = "60s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = var.notification_email != null ? [google_monitoring_notification_channel.email[0].name] : []
  enabled               = true
}

# Memory alert policy
resource "google_monitoring_alert_policy" "cloud_run_memory" {
  display_name = "${var.environment}-cloud-run-memory-alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Cloud Run Memory High"

    condition_threshold {
      filter = <<-EOT
        resource.type="cloud_run_revision"
        AND metric.type="run.googleapis.com/revision/memory/utilization"
        AND resource.label."service_name"="${var.cloud_run_service_name}"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = var.memory_threshold / 100
      duration        = "60s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = var.notification_email != null ? [google_monitoring_notification_channel.email[0].name] : []
  enabled               = true
}..
*/