# Copyright (c) HashiCorp, Inc.

output "tfc_agent_pool_name" {
  description = "The created Terraform Cloud Agent pool"
  value       = var.tfc_agent_pool_name
}

output "tfc_agent_pool_url" {
  description = "The URL for viewing Terraform Cloud Agent pools"
  value       = "https://app.terraform.io/app/${var.tfc_org_name}/settings/agents"
}
