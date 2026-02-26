resource "google_project_service" "iam_credentials" {
  project = var.project_id
  service = "iamcredentials.googleapis.com"

  disable_on_destroy = false
}
