# Copyright (c) HashiCorp, Inc.

data "google_client_config" "default" {
}

# Get the Terraform Cloud organization
data "tfe_organization" "tfc_org" {
  name = var.tfc_org_name
}

# Retrieve the  Terraform Cloud "owners" team
data "tfe_team" "tfc_team" {
  name         = "owners"
  organization = data.tfe_organization.tfc_org.name
}

# A Terraform Cloud Team token is required by the Operator
# Refer https://github.com/hashicorp/terraform-cloud-operator/blob/main/docs/usage.md
resource "tfe_team_token" "tfc_team_token" {
  team_id = data.tfe_team.tfc_team.id
}

resource "local_file" "terraform_vars" {
  filename = "${path.module}/operator/terraform.auto.tfvars"

  content = <<-EOF
  kubernetes_endpoint="https://${module.tfc_agent_gke.kubernetes_endpoint}"
  client_token="${module.tfc_agent_gke.client_token}"
  ca_certificate="${module.tfc_agent_gke.ca_certificate}"
  tfc_org_name="${data.tfe_organization.tfc_org.name}"
  tfc_team_token="${tfe_team_token.tfc_team_token.token}"
  tfc_agent_k8s_secrets="${module.tfc_agent_gke.tfc_agent_k8s_secrets}"
  EOF
}

# Create the infrastructure for the agent to run
module "tfc_agent_gke" {
  source              = "../../modules/tfc-agent-gke"
  project_id          = var.project_id
  create_network      = true
  tfc_operator_create = true
  tfc_operator_values = [file("${path.module}/values.yaml")]
  # Agent token is not needed when using operator
  tfc_agent_token = ""
}
