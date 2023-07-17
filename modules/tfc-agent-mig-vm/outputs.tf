# Copyright (c) HashiCorp, Inc.

output "mig_instance_group" {
  description = "The instance group url of the created MIG"
  value       = module.mig.instance_group
}

output "mig_name" {
  description = "The name of the MIG"
  value       = local.instance_name
}

output "mig_instance_template" {
  description = "The name of the MIG Instance Template"
  value       = module.mig_template.name
}

output "network_name" {
  description = "Name of the VPC"
  value       = local.network_name
}

output "service_account" {
  description = "Service account email used with the MIG template"
  value       = local.service_account
}
