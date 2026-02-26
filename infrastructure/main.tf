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

module "compute" {
  source      = "./modules/compute"
  project_id  = var.project_id
  region      = var.region
  environment = var.environment

  invoker_sa            = module.iam.invoker_sa_email
  service_account_email = module.iam.service_account_email

  min_instances = 0
  max_instances = 3
}

module "monitoring" {
  source                 = "./modules/monitoring"
  project_id             = var.project_id
  environment            = var.environment
  cloud_run_service_name = var.cloud_run_service_name
  cpu_threshold          = var.cpu_threshold
  memory_threshold       = var.memory_threshold
  notification_email     = var.notification_email
  cloud_run_service_id   = module.compute.cloud_run_service_id
}

resource "google_storage_bucket" "audit_log_sink" {
  name                        = "${var.project_id}-security-audit-sink"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_storage_bucket" "logging_bucket" {
  name                        = "${var.project_id}-logs"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  logging {
    log_bucket        = google_storage_bucket.audit_log_sink.name
    log_object_prefix = "access-logs/"
  }
}
