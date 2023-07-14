# Copyright (c) HashiCorp, Inc.

data "google_client_config" "default" {
}

# Create the Kubernetes secret with the Terraform Cloud team token
resource "kubernetes_secret" "tfc_team_token_secret" {
  metadata {
    name      = var.tfc_team_token_k8s_name
    namespace = var.tfc_operator_namespace
  }
  data = {
    token = var.tfc_team_token
  }
}

# Create the workspace Custom Resource to create a Terraform Cloud workspace
resource "kubernetes_manifest" "tfc_operator_workspace" {
  manifest = {
    "apiVersion" = "app.terraform.io/v1alpha2"
    "kind"       = "Workspace"
    "metadata" = {
      "name"      = var.tfc_workspace_name
      "namespace" = var.tfc_operator_namespace
    }
    "spec" = {
      "organization" = var.tfc_org_name
      "token" = {
        "secretKeyRef" = {
          "name" = var.tfc_team_token_k8s_name
          "key"  = "token"
        }
      }
      "name" = var.tfc_workspace_name
    }
  }

  # Resource doesn't destroy properly if the secret is removed first
  depends_on = [kubernetes_secret.tfc_team_token_secret]
}

# Create the AgentPool Custom Resource to deploy the Agent
# resource "kubernetes_manifest" "tfc_operator_agent_pool" {
#   manifest = {
#     "apiVersion" = "app.terraform.io/v1alpha2"
#     "kind"       = "AgentPool"
#     "metadata" = {
#       "name"      = var.tfc_agent_pool_name
#       "namespace" = var.tfc_operator_namespace
#     }
#     "spec" = {
#       "organization" = var.tfc_org_name
#       "token" = {
#         "secretKeyRef" = {
#           "name" = var.tfc_team_token_name
#           "key"  = "token"
#         }
#       }
#       "name" = var.tfc_agent_pool_name
#       "agentTokens" = [
#         {
#           "name" = "agent-token"
#         }
#       ]
#       "autoscaling" = {
#         "minReplicas"      = 2
#         "maxReplicas"      = 10
#         "targetWorkspaces" = []
#       }
#       "agentDeployment" = {
#         "replicas" = 2
#         "spec" = {
#           "containers" = [
#             {
#               "name"  = "tfc-agent"
#               "image" = var.tfc_agent_image
#               "resources" = {
#                 "requests" = {
#                   "memory" = var.tfc_agent_memory_request
#                   "cpu"    = var.tfc_agent_cpu_request
#                 }
#               }
#               "envFrom" = {
#                 "secretRef" = {
#                   "name" = var.tfc_agent_k8s_secrets
#                 }
#               }
#             }
#           ]
#         }
#       }
#     }
#   }
# }
