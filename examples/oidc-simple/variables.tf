# Copyright (c) HashiCorp, Inc.

variable "project_id" {
  type        = string
  description = "The project id to create WIF pool and example SA"
}

variable "tfc_org_name" {
  type        = string
  description = "Terraform Cloud org name where the WIF pool will be attached"
}

variable "tfc_project_name" {
  type        = string
  description = "Terraform Cloud project name where the WIF pool will be attached"
  default     = "GCP OIDC"
}

variable "tfc_workspace_name" {
  type        = string
  description = "Terraform Cloud workspace name where the WIF pool will be attached"
  default     = "gcp-oidc"
}

variable "role_list" {
  description = "Google Cloud roles required for the Service Account"
  type        = list(string)
  default = [
    "roles/storage.admin"
  ]
}
