output "cloud_run_url" {
  description = "Public URL of the Cloud Run service"
  value       = google_cloud_run_service.demo.status[0].url
}

output "service_name" {
  description = "Cloud Run service name"
  value       = google_cloud_run_service.demo.name
}

output "cloud_run_service_id" {
  value = google_cloud_run_service.demo.id  
}