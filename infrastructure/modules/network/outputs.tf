output "vpc_id" {
  description = "ID of the created VPC"
  value       = google_compute_network.vpc.id
}

output "subnet_id" {
  description = "Map of subnet names to IDs"
  value       = google_compute_subnetwork.subnets
}

output "subnet_name" {
  description = "Map of subnet names to their names"
  value       = google_compute_subnetwork.subnets
}