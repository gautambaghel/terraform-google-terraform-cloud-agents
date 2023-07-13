# Copyright (c) HashiCorp, Inc.

variable "project_id" {
  type        = string
  description = "The project id to deploy Terraform Cloud Agent MIG"
}

variable "tfc_org_name" {
  type        = string
  description = "Terraform Cloud org name where the Agent pool will be created"
}

variable "tfc_project_name" {
  type        = string
  description = "Terraform Cloud project name to be created"
  default     = "GCP Agents VM"
}

variable "tfc_workspace_name" {
  type        = string
  description = "Terraform Cloud workspace name to be created"
  default     = "tfc-agent-mig-vm-packer"
}

variable "tfc_agent_pool_name" {
  type        = string
  description = "Terraform Cloud Agent pool name to be created"
  default     = "tfc-agent-mig-vm-packer-pool"
}

variable "tfc_agent_pool_token_description" {
  type        = string
  description = "Terraform Cloud Agent pool token description"
  default     = "tfc-agent-mig-vm-packer-pool-token"
}

variable "source_image_project" {
  type        = string
  description = "Project where the source image comes from"
  default     = null
}

variable "source_image" {
  type        = string
  description = "Source disk image"
}
