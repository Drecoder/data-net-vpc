# ====================================================
# MODULES
# ====================================================

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

  # Pass the logs archive bucket name to the compute module
  logs_archive_bucket = google_storage_bucket.logs_archive.name
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

# ====================================================
# CLOUD LOGGING CONFIGURATION
# ====================================================

# 1. Create a Centralized Log Bucket in Cloud Logging
resource "google_logging_project_bucket_config" "central_log_storage" {
  project        = var.project_id
  location       = "global"
  retention_days = 365
  bucket_id      = "central-security-log-bucket"
  description    = "Centralized storage for all environment logs"
}

# 2. Create a Log Sink to route all GCS and Cloud Run logs to the bucket
resource "google_logging_project_sink" "main_audit_sink" {
  name        = "project-wide-audit-sink"
  destination = "logging.googleapis.com/${google_logging_project_bucket_config.central_log_storage.id}"
  filter = "resource.type=\"gcs_bucket\" OR resource.type=\"cloud_run_revision\""

  unique_writer_identity = true
}

/*
resource "google_project_iam_member" "log_writer" {
  project = var.project_id
  role    = "roles/logging.bucketWriter"
  member  = logging.googleapis.com / projects / data-net-488522 / locations / global / buckets / central-security-log-bucket

}
*/
# 4. Enable Data Access audit logs for GCS
resource "google_project_iam_audit_config" "gcs_audit" {
  project = var.project_id
  service = "storage.googleapis.com"

  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

# ====================================================
# GCS BUCKETS (Hardened & Scanned)
# ====================================================

# LOG SINK BUCKET
resource "google_storage_bucket" "log_sink_bucket" {
  # checkov:skip=CKV_GCP_62: Terminal log sink; access logs are captured by Cloud Logging sink.
  name                        = "${var.project_id}-log-sink"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}

# LOGS ARCHIVE
resource "google_storage_bucket" "logs_archive" {
  # checkov:skip=CKV_GCP_62: Access logs are captured by Cloud Logging sink.
  name                        = "${var.project_id}-logs-archive"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type = "Delete"
    }
  }
}

# AUDIT LOG SINK
resource "google_storage_bucket" "audit_log_sink" {
  # checkov:skip=CKV_GCP_62: Access logs are captured by Cloud Logging sink.
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

# LOGGING BUCKET
resource "google_storage_bucket" "logging_bucket" {
  # checkov:skip=CKV_GCP_62: Access logs are captured by Cloud Logging sink.
  name                        = "${var.project_id}-logs"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}