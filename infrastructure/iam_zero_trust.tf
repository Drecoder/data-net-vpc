# 1. Create the Workload Identity Pool
resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "GitHub Actions Pool"
  description               = "Identity pool for GitHub Actions"
}

# 2. Create the OIDC Provider (The actual handshake)
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "google.groups"              = "assertion.groups"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.ref"              = "assertion.ref"
    "attribute.actor"            = "assertion.actor"
    "attribute.aud"              = "assertion.aud"
    "attribute.workflow"         = "assertion.workflow"
    "attribute.job_workflow_ref" = "assertion.job_workflow_ref"
    "attribute.environment"      = "assertion.environment"
  }



  attribute_condition = "assertion.sub == 'repo:Drecoder/data-net-vpc'"


  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# 3. Bind the Pool to your Service Account (The "Keyless" Permission)
resource "google_service_account_iam_member" "wif_binding" {
  service_account_id = "projects/data-net-488522/serviceAccounts/dev-demo-service-account@data-net-488522.iam.gserviceaccount.com"
  role               = "roles/iam.workloadIdentityUser"

  # IMPORTANT: Replace YOUR_USERNAME/YOUR_REPO with your actual GitHub info
  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/Drecoder/data-net-vpc"

}