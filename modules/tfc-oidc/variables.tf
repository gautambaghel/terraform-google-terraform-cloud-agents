# Copyright (c) HashiCorp, Inc.

variable "project_id" {
  type        = string
  description = "The Google Cloud Platform project id to use"
}

variable "service_list" {
  description = "Google Cloud APIs required for the project"
  type        = list(string)
  default = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sts.googleapis.com",
    "iamcredentials.googleapis.com"
  ]
}

variable "pool_id" {
  type        = string
  description = "Workload Identity Pool ID"
}

variable "pool_display_name" {
  type        = string
  description = "Workload Identity Pool display name"
  default     = null
}

variable "pool_description" {
  type        = string
  description = "Workload Identity Pool description"
  default     = "Workload Identity Pool managed by Terraform"
}

variable "provider_id" {
  type        = string
  description = "Workload Identity Pool Provider id"
}

variable "provider_display_name" {
  type        = string
  description = "Workload Identity Pool Provider display name"
  default     = null
}

variable "provider_description" {
  type        = string
  description = "Workload Identity Pool Provider description"
  default     = "Workload Identity Pool Provider managed by Terraform"
}

variable "attribute_condition" {
  type        = string
  description = <<-EOF
    Workload Identity Pool Provider attribute condition expression. 
    [More info](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider#attribute_condition)
  EOF
  default     = ""
}

variable "attribute_mapping" {
  type        = map(any)
  description = <<-EOF
    Workload Identity Pool Provider attribute mapping. 
    [More info](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider#attribute_mapping)
    EOF
  default = {
    "google.subject"                        = "assertion.sub",
    "attribute.aud"                         = "assertion.aud",
    "attribute.terraform_run_phase"         = "assertion.terraform_run_phase",
    "attribute.terraform_project_id"        = "assertion.terraform_project_id",
    "attribute.terraform_project_name"      = "assertion.terraform_project_name",
    "attribute.terraform_workspace_id"      = "assertion.terraform_workspace_id",
    "attribute.terraform_workspace_name"    = "assertion.terraform_workspace_name",
    "attribute.terraform_organization_id"   = "assertion.terraform_organization_id",
    "attribute.terraform_organization_name" = "assertion.terraform_organization_name",
    "attribute.terraform_run_id"            = "assertion.terraform_run_id",
    "attribute.terraform_full_workspace"    = "assertion.terraform_full_workspace",
  }
}

variable "allowed_audiences" {
  type        = list(string)
  description = "Workload Identity Pool Provider allowed audiences."
  default     = []
}

variable "issuer_uri" {
  type        = string
  description = <<-EOF
    Workload Identity Pool Issuer URL for Terraform Cloud/Enterprise. The default audience format used by TFC is of the form
    //iam.googleapis.com/projects/{project number}/locations/global/workloadIdentityPools/{pool ID}/providers/{provider ID}
    which matches with the default accepted audience format on GCP.
  EOF
  default     = "https://app.terraform.io"
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
}

variable "tfc_project_name" {
  type        = string
  default     = "Default Project"
  description = "The Terraform Cloud project to authorize via OIDC"
}

variable "tfc_workspace_name" {
  type        = string
  default     = "gcp-oidc-workspace"
  description = "The name of the Terraform Cloud workspace to authorize via OIDC"
}

variable "sa_mapping" {
  type = map(object({
    sa_name   = string
    sa_email  = string
    attribute = string
  }))
  description = <<-EOF
    Service Account resource names and corresponding WIF provider attributes. 
    If attribute is set to `*` all identities in the pool are granted access to SAs.
  EOF
  default     = {}
}
