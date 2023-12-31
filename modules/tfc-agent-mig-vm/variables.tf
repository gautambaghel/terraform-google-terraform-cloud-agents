# Copyright (c) HashiCorp, Inc.

variable "project_id" {
  type        = string
  description = "The Google Cloud Platform project ID to deploy Terraform Cloud agent"
}

variable "region" {
  type        = string
  description = "The GCP region to use when deploying resources"
  default     = "us-central1"
}

variable "create_network" {
  type        = bool
  description = "When set to true, VPC, router and NAT will be auto created"
  default     = true
}

variable "network_name" {
  type        = string
  description = "Name for the VPC network"
  default     = "tfc-agent-network"
}

variable "subnetwork_project" {
  type        = string
  description = <<-EOF
    The project ID of the shared VPCs host (for shared vpc support). 
    If not provided, the project_id is used
  EOF
  default     = ""
}

variable "subnet_ip" {
  type        = string
  description = "IP range for the subnet"
  default     = "10.10.10.0/24"
}

variable "subnet_name" {
  type        = string
  description = "Name for the subnet"
  default     = "tfc-agent-subnet"
}

variable "min_replicas" {
  type        = number
  description = "Minimum number of Terraform agent instances"
  default     = 1
}

variable "max_replicas" {
  type        = number
  description = "Maximum number of Terraform agent instances"
  default     = 10
}

variable "service_account" {
  type        = string
  description = "Service account email address to use with the MIG template"
  default     = ""
}

variable "machine_type" {
  type        = string
  description = "The GCP machine type to deploy"
  default     = "n1-standard-1"
}

variable "source_image_family" {
  type        = string
  description = <<-EOF
    Source image family. If neither source_image nor source_image_family 
    is specified, defaults to the latest public Ubuntu image
  EOF
  default     = "ubuntu-2204-lts"
}

variable "source_image_project" {
  type        = string
  description = "Project where the source image originates"
  default     = "ubuntu-os-cloud"
}

variable "source_image" {
  type        = string
  description = <<-EOF
    Source disk image. If neither source_image nor source_image_family is specified,
    defaults to the latest public CentOS image
  EOF
  default     = ""
}

variable "startup_script" {
  type        = string
  description = "User startup script to run when instances spin up"
  default     = ""
}

variable "custom_metadata" {
  type        = map(any)
  description = "User provided custom metadata"
  default     = {}
}

variable "cooldown_period" {
  type        = number
  description = <<-EOF
    The number of seconds that the autoscaler should wait before it 
    starts collecting information from a new instance
  EOF
  default     = 60
}

variable "tfc_agent_address" {
  type        = string
  description = "The HTTP or HTTPS address of the Terraform Cloud/Enterprise API"
  default     = "https://app.terraform.io"
}

variable "tfc_agent_single" {
  type        = bool
  description = <<-EOF
    Enable single mode. This causes the agent to handle at most one job and
    immediately exit thereafter. Useful for running agents as ephemeral
    containers, VMs, or other isolated contexts with a higher-level scheduler
    or process supervisor
  EOF
  default     = false
}

variable "tfc_agent_auto_update" {
  type        = string
  description = <<-EOF
    Controls automatic core updates behavior. 
    Acceptable values include disabled, patch, and minor
  EOF
  default     = "minor"
}

variable "tfc_agent_name_prefix" {
  type        = string
  description = <<-EOF
    This name may be used in the Terraform Cloud user interface to help 
    easily identify the agent
  EOF
  default     = "tfc-agent-mig-vm"
}

variable "tfc_agent_labels" {
  type        = set(string)
  description = "Terraform Cloud agent labels to attach to the VMs"
  default     = []
}

variable "tfc_agent_version" {
  type        = string
  description = "Terraform Cloud Agent version to install"
  default     = "1.10.1"
}

variable "tfc_agent_token" {
  type        = string
  description = "Terraform Cloud agent token. (Organization Settings >> Agents)"
  sensitive   = true
}
