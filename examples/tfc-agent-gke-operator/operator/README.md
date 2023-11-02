# Deploy the Terraform Cloud operator Custom Resource on GKE

This is a subfolder that showcases how the operator Custom Resources can be deployed to create Workspace, AgentPools and Modules.

For more information about Kubernetes secrets please refer to the [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/secret/). Please use the approach that is matching with the best practices which are accepted in your organization.

Controllers usage guides:
  - [AgentPool](https://github.com/hashicorp/terraform-cloud-operator/blob/main/docs/agentpool.md)
  - [Module](https://github.com/hashicorp/terraform-cloud-operator/blob/main/docs/module.md)
  - [Workspace](https://github.com/hashicorp/terraform-cloud-operator/blob/main/docs/workspace.md)

## Steps to deploy this example

1. Create the operator CRDs.

    ```sh
    terraform init
    terraform plan
    terraform apply
    ```

1. Your Terraform Cloud Agents should become active at Organization Setting > Security > Agents.

1. Create additonal workspaces or use the existing workspace to run Terraform through the Terraform Cloud Agent. [Click here for more info on running the workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_run#example-usage).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ca\_certificate | The Google Kubernetes CA certificate | `string` | n/a | yes |
| kubernetes\_endpoint | The Google Kubernetes endpoint | `string` | n/a | yes |
| tfc\_agent\_cpu\_request | CPU request for the Terraform Cloud Agent container | `string` | `"2"` | no |
| tfc\_agent\_image | The Terraform Cloud Agent image to use | `string` | `"hashicorp/tfc-agent"` | no |
| tfc\_agent\_max\_replicas | Maximum replicas for the Terraform Cloud Agent pod autoscaler. Does not apply if using operator | `string` | `"10"` | no |
| tfc\_agent\_memory\_request | Memory request for the Terraform Cloud Agent container | `string` | `"2Gi"` | no |
| tfc\_agent\_min\_replicas | Minimum replicas for the Terraform Cloud Agent pod autoscaler. Does not apply if using operator | `string` | `"2"` | no |
| tfc\_agent\_pool\_name | Terraform Cloud Agent pool name to be created | `string` | `"tfc-agent-gke-operator-pool"` | no |
| tfc\_agent\_replicas | Deployment replicas for Terraform Cloud Agent. Does not apply if using operator | `string` | `"2"` | no |
| tfc\_operator\_namespace | The K8s namespace to deploy Terraform Cloud operator resources | `string` | `"terraform-cloud-operator-system"` | no |
| tfc\_org\_name | Terraform Cloud org name where the agent pool will be created | `string` | n/a | yes |
| tfc\_team\_token | The Terraform Cloud Agent image to use | `string` | n/a | yes |
| tfc\_team\_token\_k8s\_name | Name for the K8s secret that stores TFC team API token | `string` | `"tfc-operator-token"` | no |
| tfc\_workspace\_name | Terraform Cloud workspace name to be created | `string` | `"tfc-agent-gke-operator"` | no |

## Outputs

| Name | Description |
|------|-------------|
| tfc\_agent\_pool\_name | The created Terraform Cloud Agent pool |
| tfc\_agent\_pool\_url | The URL for viewing Terraform Cloud Agent pools |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
