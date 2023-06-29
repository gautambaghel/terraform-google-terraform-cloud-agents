# Copyright (c) HashiCorp, Inc.

data "google_client_config" "default" {
}

# Get the Terraform Cloud organization
data "tfe_organization" "tfc_org" {
  name = var.tfc_org_name
}

# Create a new project in Terraform Cloud
resource "tfe_project" "tfc_project" {
  organization = data.tfe_organization.tfc_org.name
  name         = var.tfc_project_name
}

# Create a new workspace which uses the agent to run Terraform
resource "tfe_workspace" "tfc_workspace" {
  name           = var.tfc_workspace_name
  organization   = data.tfe_organization.tfc_org.name
  project_id     = tfe_project.tfc_project.id
  agent_pool_id  = tfe_agent_pool.tfc_agent_pool.id
  execution_mode = "agent"
}

# Create a new Agent pool in organization
resource "tfe_agent_pool" "tfc_agent_pool" {
  name         = var.tfc_agent_pool_name
  organization = data.tfe_organization.tfc_org.name
}

# Create a new token for the Agent pool
resource "tfe_agent_token" "tfc_agent_token" {
  agent_pool_id = tfe_agent_pool.tfc_agent_pool.id
  description   = var.tfc_agent_pool_token
}

# Create the infrastructure for the Agent to run
module "tfc_agent_gke" {
  source          = "../../modules/tfc-agent-gke"
  create_network  = true
  project_id      = var.project_id
  tfc_agent_token = tfe_agent_token.tfc_agent_token.token
}

# Deploy the Agent
resource "kubernetes_deployment" "tfc_agent_deployment" {
  metadata {
    name = "tfc-agent-deployment"
  }

  spec {
    selector {
      match_labels = {
        app = "tfc-agent"
      }
    }

    replicas = 2

    template {
      metadata {
        labels = {
          app = "tfc-agent"
        }
      }

      spec {
        container {
          name  = "tfc-agent"
          image = "hashicorp/tfc-agent:latest"

          env {
            name = "TFC_ADDRESS"
            value_from {
              secret_key_ref {
                name = "tfc-agent-k8s-secrets"
                key  = "tfc_agent_address"
              }
            }
          }

          env {
            name = "TFC_AGENT_TOKEN"
            value_from {
              secret_key_ref {
                name = "tfc-agent-k8s-secrets"
                key  = "tfc_agent_token"
              }
            }
          }

          env {
            name = "TFC_AGENT_NAME"
            value_from {
              secret_key_ref {
                name = "tfc-agent-k8s-secrets"
                key  = "tfc_agent_name"
              }
            }
          }

          env {
            name = "TFC_AGENT_SINGLE"
            value_from {
              secret_key_ref {
                name = "tfc-agent-k8s-secrets"
                key  = "tfc_agent_single"
              }
            }
          }

          env {
            name = "TFC_AGENT_AUTO_UPDATE"
            value_from {
              secret_key_ref {
                name = "tfc-agent-k8s-secrets"
                key  = "tfc_agent_auto_update"
              }
            }
          }

          resources {
            requests = {
              memory = "256Mi"
              cpu    = "500m"
            }

            limits = {
              memory = "512Mi"
              cpu    = "1"
            }
          }
        }
      }
    }
  }
}

# Deploy a horizontal pod autoscaler for the Agent
resource "kubernetes_horizontal_pod_autoscaler_v2" "tfc_agent_hpa" {
  metadata {
    name = "tfc-agent-deployment-hpa"
  }

  spec {
    scale_target_ref {
      kind = "Deployment"
      name = "tfc-agent-deployment"
    }

    min_replicas = 2
    max_replicas = 10

    metric {
      type = "Resource"

      resource {
        name = "cpu"

        target {
          type                = "Utilization"
          average_utilization = 50
        }
      }
    }
  }
}
