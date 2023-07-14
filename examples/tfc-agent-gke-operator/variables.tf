# Copyright (c) HashiCorp, Inc.

variable "project_id" {
  type        = string
  description = "The Project ID to deploy Terraform Cloud Agent"
}

variable "tfc_org_name" {
  type        = string
  description = "Terraform Cloud org name where the agent pool will be created"
}
