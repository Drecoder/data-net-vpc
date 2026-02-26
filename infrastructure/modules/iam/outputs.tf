output "service_account_email" {
  description = "Email of the service account to be used by Cloud Run"
  value       = google_service_account.demo.email
}

output "service_account_id" {
  description = "ID of the service account"
  value       = google_service_account.demo.account_id
}