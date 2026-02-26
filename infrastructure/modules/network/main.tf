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
  network       = google_compute_network.vpc.id
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "deny_all" {
  name    = "${var.environment}-deny-all"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 65535

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}