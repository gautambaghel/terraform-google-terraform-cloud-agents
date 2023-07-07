# Copyright (c) HashiCorp, Inc.

output "pool_name" {
  description = "Pool name"
  value       = google_iam_workload_identity_pool.tfc_pool.name
}

output "provider_name" {
  description = "Provider name"
  value       = google_iam_workload_identity_pool_provider.tfc_provider.name
}
