# Copyright (c) HashiCorp, Inc.

variable "kubernetes_endpoint" {
  type        = string
  description = "The Google Kubernetes endpoint"
}

variable "ca_certificate" {
  type        = string
  description = "The Google Kubernetes CA certificate"
}

variable "tfc_org_name" {
  type        = string
  description = "Terraform Cloud org name where the agent pool will be created"
}

variable "tfc_workspace_name" {
  type        = string
  description = "Terraform Cloud workspace name to be created"
  default     = "tfc-agent-gke-operator"
}

variable "tfc_team_token" {
  description = "The Terraform Cloud Agent image to use"
  type        = string
}

variable "tfc_operator_namespace" {
  description = "The K8s namespace to deploy Terraform Cloud operator resources"
  type        = string
  default     = "terraform-cloud-operator-system"
}

variable "tfc_team_token_k8s_name" {
  type        = string
  description = "Name for the K8s secret that stores TFC team API token"
  default     = "tfc-operator-token"
}

variable "tfc_agent_pool_name" {
  type        = string
  description = "Terraform Cloud Agent pool name to be created"
  default     = "tfc-agent-gke-operator-pool"
}

variable "tfc_agent_image" {
  type        = string
  description = "The Terraform Cloud Agent image to use"
  default     = "hashicorp/tfc-agent"
}

variable "tfc_agent_memory_request" {
  type        = string
  description = "Memory request for the Terraform Cloud Agent container"
  default     = "2Gi"
}

variable "tfc_agent_cpu_request" {
  type        = string
  description = "CPU request for the Terraform Cloud Agent container"
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
