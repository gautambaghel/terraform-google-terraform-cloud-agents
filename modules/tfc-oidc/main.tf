# Copyright (c) HashiCorp, Inc.

locals {
  attribute_condition = var.attribute_condition == "" ? "assertion.sub.startsWith(\"organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}\")" : var.attribute_condition
  service_account     = var.service_account == "" ? google_service_account.tfc_oidc_service_account[0].email : var.service_account
}

# Enables the required services in the project.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "services" {
  project            = var.project_id
  count              = length(var.service_list)
  service            = var.service_list[count.index]
  disable_on_destroy = false
}

# Creates a workload identity pool to house a workload identity pool provider.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool
resource "google_iam_workload_identity_pool" "tfc_pool" {
  project                   = var.project_id
  workload_identity_pool_id = var.pool_id
  display_name              = var.pool_display_name
  description               = var.pool_description
  disabled                  = false
}

# Creates an identity pool provider which uses an attribute condition
# to ensure that only the specified Terraform Cloud workspace will be
# able to authenticate to GCP using this provider.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider
resource "google_iam_workload_identity_pool_provider" "tfc_provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.tfc_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = var.provider_display_name
  description                        = var.provider_description
  attribute_mapping                  = var.attribute_mapping
  attribute_condition                = local.attribute_condition
  oidc {
    issuer_uri        = var.issuer_uri
    allowed_audiences = var.allowed_audiences
  }
}

resource "google_service_account" "tfc_oidc_service_account" {
  count        = var.service_account == "" ? 1 : 0
  project      = var.project_id
  account_id   = "tfc-oidc-service-account"
  display_name = "Terraform Cloud Service Account"
}

# Allows the service account to act as a workload identity user.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
resource "google_service_account_iam_member" "tfc_service_account_member" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${local.service_account}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.tfc_pool.name}/*"
}

# Updates the IAM policy to grant the service account permissions
# within the project.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "tfc_project_member" {
  project  = var.project_id
  for_each = toset(var.role_list)
  role     = each.value
  member   = "serviceAccount:${local.service_account}"
}
