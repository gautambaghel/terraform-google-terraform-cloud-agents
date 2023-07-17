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
  description = "Name for the k8s secret required to configure TFC agent on GKE. Does not apply if using operator"
  default     = "tfc-agent-k8s-secrets"
}

variable "tfc_agent_k8s_secrets_namespace" {
  type        = string
  description = "Name for the k8s secret required to configure TFC agent on GKE. Does not apply if using operator"
  default     = "terraform-cloud-operator-system"
}

variable "tfc_agent_address" {
  type        = string
  description = "The HTTP or HTTPS address of the Terraform Cloud/Enterprise API. Does not apply if using operator"
  default     = "https://app.terraform.io"
}

variable "tfc_agent_single" {
  type        = bool
  description = <<-EOF
    Enable single mode. This causes the agent to handle at most one job and
    immediately exit thereafter. Useful for running agents as ephemeral
    containers, VMs, or other isolated contexts with a higher-level scheduler
    or process supervisor. Does not apply if using operator
  EOF
  default     = false
}

variable "tfc_agent_auto_update" {
  type        = string
  description = <<-EOF
    Controls automatic core updates behavior. 
    Acceptable values include disabled, patch, and minor. 
    Does not apply if using operator
  EOF
  default     = "minor"
}

variable "tfc_agent_name_prefix" {
  type        = string
  description = <<-EOF
    This name may be used in the Terraform Cloud user interface to help easily identify the agent. 
    Does not apply if using operator
  EOF
  default     = "tfc-agent-k8s"
}

variable "tfc_agent_token" {
  type        = string
  description = <<-EOF
    Terraform Cloud Agent token. (TFC Organization Settings >> Agents). 
    Does not apply if using operator
  EOF
  sensitive   = true
  default     = ""
}

variable "tfc_agent_image" {
  type        = string
  description = "The Terraform Cloud agent image to use. Does not apply if using operator"
  default     = "hashicorp/tfc-agent:latest"
}

variable "tfc_agent_memory_request" {
  type        = string
  description = "Memory request for the Terraform Cloud agent container. Does not apply if using operator"
  default     = "2Gi"
}

variable "tfc_agent_cpu_request" {
  type        = string
  description = "CPU request for the Terraform Cloud agent container. Does not apply if using operator"
  default     = "2"
}

variable "tfc_agent_replicas" {
  type        = string
  description = "Deployment replicas for Terraform Cloud Agent. Does not apply if using operator"
  default     = "2"
}

variable "tfc_agent_min_replicas" {
  type        = string
  description = "Minimum replicas for the Terraform Cloud Agent pod autoscaler. Does not apply if using operator"
  default     = "2"
}

variable "tfc_agent_max_replicas" {
  type        = string
  description = "Maximum replicas for the Terraform Cloud Agent pod autoscaler. Does not apply if using operator"
  default     = "10"
}

variable "tfc_agent_average_utilization" {
  type        = string
  description = <<-EOF
    Average CPU utilization for the Terraform Cloud Agent for autoscaling. 
    Does not apply if using operator
  EOF
  default     = "50"
}

variable "tfc_operator_create" {
  type        = bool
  description = "Set true, if using the Terraform Cloud Operator"
  default     = false
}

variable "tfc_operator_create_namespace" {
  type        = bool
  description = "Set true, creates a namespace for the Terraform Cloud Operator"
  default     = true
}

variable "tfc_operator_version" {
  type        = string
  description = "Terraform Cloud Operator version"
  default     = "2.0.0-beta7"
}

variable "tfc_operator_values" {
  type        = any
  description = "The values.yaml file used for deploying Terraform Cloud Operator"
  default     = {}
}
