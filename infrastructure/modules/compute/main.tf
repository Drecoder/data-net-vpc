resource "google_cloud_run_service" "demo" {
  name     = "${var.environment}-demo"
  location = var.region

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = tostring(var.min_instances)
        "autoscaling.knative.dev/maxScale" = tostring(var.max_instances)
      }
    }

    spec {
      service_account_name = var.service_account_email

      containers {
        image = var.image

        resources {
          limits = {
            memory = "256Mi"
            cpu    = "1"
          }
        }

        # FIX 1: 'env' must be a dynamic block for "Engineering Excellence"
        dynamic "env" {
          for_each = var.environment_variables
          content {
            name  = env.key
            value = env.value
          }
        }
      }
    }
  }

  # FIX 2: Change 'traffics' (plural) to 'traffic' (singular)
  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.demo.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.invoker_sa}"
}