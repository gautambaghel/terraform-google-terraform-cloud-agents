# Copyright (c) HashiCorp, Inc.

data "google_client_config" "default" {
}

module "tfc-agent-gke" {
  source          = "../../modules/tfc-agent-gke"
  create_network  = true
  project_id      = var.project_id
  tfc_agent_token = var.tfc_agent_token
}
