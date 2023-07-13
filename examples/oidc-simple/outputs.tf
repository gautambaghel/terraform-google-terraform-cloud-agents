# Copyright (c) HashiCorp, Inc.

output "pool_name" {
  description = "Pool name"
  value       = module.oidc.pool_name
}

output "provider_name" {
  description = "Provider name"
  value       = module.oidc.provider_name
}

output "tfc_workspace_name" {
  description = "Terraform Cloud workspace name with OIDC configured"
  value       = tfe_workspace.tfc_workspace.name
}
