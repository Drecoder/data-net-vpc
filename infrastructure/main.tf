
module "network" {
  source      = "./modules/network"
  project_id  = var.project_id
  region      = var.region
  environment = var.environment
}

module "iam" {
  source      = "./modules/iam"
  project_id  = var.project_id
  environment = var.environment
}

module "monitoring" {
  source                 = "./modules/monitoring"
  project_id             = var.project_id
  environment            = var.environment
  cloud_run_service_name = var.cloud_run_service_name
  cpu_threshold          = var.cpu_threshold
  memory_threshold       = var.memory_threshold
  notification_email     = var.notification_email
}

module "compute" {
  source      = "./modules/compute"
  project_id  = var.project_id
  region      = var.region
  environment = var.environment

  service_account_email = module.iam.service_account_email

  min_instances = 0
  max_instances = 3
}

# This resource is for testing Checkov security gates
resource "google_storage_bucket" "insecure_test_bucket" {
  name          = "${var.project_id}-insecure-test"
  location      = "US"
  force_destroy = true

  # CHECKOV TRIGGER: Missing 'public_access_prevention' 
  # CHECKOV TRIGGER: Missing 'uniform_bucket_level_access'
}