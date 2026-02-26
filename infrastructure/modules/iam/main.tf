resource "google_service_account" "demo" {
  account_id   = "${var.environment}-${var.service_account_name}"
  display_name = "${var.environment} Demo Service Account"
  project      = var.project_id
}

# Grant roles to the service account
resource "google_project_iam_member" "demo_roles" {
  for_each = toset(var.roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.demo.email}"
}