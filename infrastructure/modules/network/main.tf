# 1. The VPC Resource
resource "google_compute_network" "vpc" {
  name                    = "${var.environment}-vpc"
  auto_create_subnetworks = false # Excellence Grade: Never use auto-subnets
}

# 2. The Subnet Resource
resource "google_compute_subnetwork" "subnets" {
  name          = "${var.environment}-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region

  # This MUST match the resource label above
  network = google_compute_network.vpc.id

  # For your Security-First requirement:
  private_ip_google_access = true
}