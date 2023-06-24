# Example TFC Agent on MIG Container VM

## Overview

This example shows how to deploy a Terraform Cloud Agent on GCE Container VM.

## Steps to deploy this example

1. Create the agent pool in Terraform Cloud by navigating to Organization Setting > Security > Agents > Create Agent Pool.
   [More info here](https://developer.hashicorp.com/terraform/cloud-docs/agents/agent-pools#create-an-agent-pool).

2. Create terraform.tfvars file with the necessary values.

    The Terraform Cloud agent token you would like to use. NOTE: This is a secret and should be marked as sensitive in Terraform Cloud.

    ```tf
    project_id = "your-project-id"
    tfc_agent_token   = "your-tfc-agent-token"
    ```

3. Create the infrastructure.

    ```sh
    $ terraform init
    $ terraform plan
    $ terraform apply
    ```

4. Your Terraform Cloud Agents should become active at Organization Setting > Security > Agents.

5. Create a workspace or use an existing workspace to attach the Terraform Cloud Agent.
   [More info here](https://developer.hashicorp.com/terraform/cloud-docs/agents/agent-pools#configure-workspaces-to-use-the-agent).



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project id to deploy Terraform Agent MIG | `string` | n/a | yes |
| tfc\_agent\_token | Terraform Cloud agent token. (mark as sensitive) (TFC Organization Settings >> Agents) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| mig\_instance\_group | The instance group url of the created MIG |
| mig\_instance\_template | The name of the MIG Instance Template |
| mig\_name | The name of the MIG |
| service\_account | Service account email for GCE |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
