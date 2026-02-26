/*
 output "cpu_alert_policy_name" {
 description = "Name of the CPU alert policy"
  value       = google_monitoring_alert_policy.cloud_run_cpu.name
}

output "memory_alert_policy_name" {
  description = "Name of the Memory alert policy"
  value       = google_monitoring_alert_policy.cloud_run_memory.name
}

output "notification_channel_email" {
  description = "Email notification channel created for alerts (if any)"
  value       = var.notification_email != null ? google_monitoring_notification_channel.email[0].name : null
}
*/