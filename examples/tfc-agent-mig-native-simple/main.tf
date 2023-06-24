# Copyright (c) HashiCorp, Inc.

module "tfc-agent-mig" {
  source          = "../../modules/tfc-agent-mig-vm"
  create_network  = true
  project_id      = var.project_id
  tfc_agent_token = var.tfc_agent_token
}
