# Copyright (c) HashiCorp, Inc.

# Get the Terraform Cloud organization
data "tfe_organization" "tfc_org" {
  name = var.tfc_org_name
}

# Create a new project in Terraform Cloud
resource "tfe_project" "tfc_project" {
  organization = data.tfe_organization.tfc_org.name
  name         = var.tfc_project_name
}

# Create a new workspace which uses the agent to run Terraform
resource "tfe_workspace" "tfc_workspace" {
  name         = var.tfc_workspace_name
  organization = data.tfe_organization.tfc_org.name
  project_id   = tfe_project.tfc_project.id
}

resource "google_service_account" "sa" {
  project    = var.project_id
  account_id = "ex-storage-sa"
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

module "oidc" {
  source      = "../../modules/tfc-oidc"
  project_id  = var.project_id
  pool_id     = "ex-pool"
  provider_id = "ex-tfc-provider"
  sa_mapping = {
    (google_service_account.sa.account_id) = {
      sa_name   = google_service_account.sa.name
      sa_email  = google_service_account.sa.email
      attribute = "*"
    }
  }
  tfc_organization_name = data.tfe_organization.tfc_org.name
  tfc_project_name      = tfe_project.tfc_project.name
  tfc_workspace_name    = tfe_workspace.tfc_workspace.name
}
