# Copyright (c) HashiCorp, Inc.

variable "project_id" {
  type        = string
  description = "The Google Cloud Platform project ID to deploy Terraform Cloud agent cluster"
}

variable "region" {
  type        = string
  description = "The GCP region to use when deploying resources"
  default     = "us-central1"
}

variable "zones" {
  type        = list(string)
  description = "The GCP zone to use when deploying resources"
  default     = ["us-central1-a"]
}

variable "ip_range_pods_name" {
  type        = string
  description = "The secondary IP range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  type        = string
  description = "The secondary IP range to use for services"
  default     = "ip-range-scv"
}

variable "ip_range_pods_cidr" {
  type        = string
  description = "The secondary IP range CIDR to use for pods"
  default     = "192.168.0.0/18"
}

variable "ip_range_services_cider" {
  type        = string
  description = "The secondary IP range CIDR to use for services"
  default     = "192.168.64.0/18"
}

variable "network_name" {
  type        = string
  description = "Name for the VPC network"
  default     = "tfc-agent-network"
}

variable "subnet_ip" {
  type        = string
  description = "IP range for the subnet"
  default     = "10.0.0.0/17"
}

variable "subnet_name" {
  type        = string
  description = "Name for the subnet"
  default     = "tfc-agent-subnet"
}

variable "create_network" {
  type        = bool
  description = "When set to true, VPC will be auto created"
  default     = true
}

variable "network_project_id" {
  type        = string
  description = <<-EOF
    The project ID of the shared VPCs host (for shared vpc support). 
    If not provided, the project_id is used
  EOF
  default     = ""
}

variable "machine_type" {
  type        = string
  description = "Machine type for TFC agent node pool"
  default     = "n1-standard-4"
}

variable "max_node_count" {
  type        = number
  description = "Maximum number of nodes in the TFC agent node pool"
  default     = 4
}

variable "min_node_count" {
  type        = number
  description = "Minimum number of nodes in the TFC agent node pool"
  default     = 2
}

variable "service_account" {
  type        = string
  description = "Optional Service Account for the GKE nodes"
  default     = ""
}

variable "tfc_agent_k8s_secrets" {
  type        = string
  description = "Name for the k8s secret required to configure TFC agent on GKE"
  default     = "tfc-agent-k8s-secrets"
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
    or process supervisor.
  EOF
  default     = false
}

variable "tfc_agent_auto_update" {
  type        = string
  description = "Controls automatic core updates behavior. Acceptable values include disabled, patch, and minor"
  default     = "minor"
}

variable "tfc_agent_name_prefix" {
  type        = string
  description = "This name may be used in the Terraform Cloud user interface to help easily identify the agent"
  default     = "tfc-agent-k8s"
}

variable "tfc_agent_image" {
  type        = string
  description = "The Terraform Cloud agent image to use"
  default     = "hashicorp/tfc-agent:latest"
}

variable "tfc_agent_memory_request" {
  type        = string
  description = "Memory request for the Terraform Cloud agent container"
  default     = "2Gi"
}

variable "tfc_agent_cpu_request" {
  type        = string
  description = "CPU request for the Terraform Cloud agent container"
  default     = "2"
}

variable "tfc_agent_token" {
  type        = string
  description = "Terraform Cloud agent token. (Organization Settings >> Agents)"
  sensitive   = true
}
