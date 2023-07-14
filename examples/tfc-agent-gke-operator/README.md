# Simple Self Hosted Terraform Cloud agent on GKE

## Overview

This example shows how to deploy Terraform Cloud agents on Google Kubernetes Engine (GKE) using the `tfc-agent-gke` module.

It creates the Terraform Cloud agent pool, registers the agent to that pool and creates a project and an empty workspace with the agent attached.

## Prerequisites

The tools needed to build this example are available by default in Google Cloud Shell.

If running from your own system, you will need:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)

## Steps to deploy this example

1. Create terraform.tfvars file with the necessary values.

    The Terraform Cloud agent token you would like to use. NOTE: This is a secret and should be marked as sensitive in Terraform Cloud.

    ```tf
    project_id      = "your-project-id"
    tfc_agent_token = "your-tfc-agent-token"
    ```

1. Create the primary infrastructure.

    ```sh
    terraform init
    terraform plan
    terraform apply
    ```

1. Create the operator CRDs.

    ```sh
    cd operator/
    terraform init
    terraform plan
    terraform apply
    ```

1. Your Terraform Cloud agents should become active at Organization Setting > Security > Agents.

1. Create additonal workspaces or use the existing workspace to run Terraform through the Terraform Cloud agent. [Click here for more info on running the workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_run#example-usage).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The Project ID to deploy Terraform Cloud agent | `string` | n/a | yes |
| tfc\_org\_name | Terraform Cloud org name where the agent pool will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ca\_certificate | The cluster CA certificate (base64 encoded) |
| client\_token | The bearer token for auth |
| cluster\_name | GKE cluster name |
| kubernetes\_endpoint | The GKE cluster endpoint |
| location | GKE cluster location |
| network\_name | Name of the VPC |
| service\_account | The default service account used for running nodes |
| subnet\_name | Name of the subnet in the VPC |
| tfc\_agent\_k8s\_secrets | Name for the K8s secret that stores TFC agent configurations |
| tfc\_team\_token | value |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
