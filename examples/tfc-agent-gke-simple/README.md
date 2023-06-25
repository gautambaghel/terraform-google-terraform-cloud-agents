# Simple Self Hosted TFC Agent on GKE

## Overview

This example shows how to deploy TFC Agent on GKE.

## Steps to deploy this example

1. Create terraform.tfvars file with the necessary values.

    The Terraform Cloud agent token you would like to use. NOTE: This is a secret and should be marked as sensitive in Terraform Cloud.

    ```tf
    project_id = "your-project-id"
    tfc_agent_token   = "your-tfc-agent-token"
    ```

1. Create the infrastructure.

    ```sh
    $ terraform init
    $ terraform plan
    $ terraform apply
    ```

1. Build the example TFC Agent image using Google Cloud Build. Alternatively, you can also use a prebuilt image or build using a local docker daemon.

    ```sh
    $ gcloud config set project $PROJECT_ID
    $ gcloud services enable cloudbuild.googleapis.com
    $ gcloud builds submit --config=cloudbuild.yaml
    ```

1. Replace image in [sample k8s deployment manifest](./sample-manifests/deployment.yaml).

    ```sh
    $ kustomize edit set image gcr.io/PROJECT_ID/tfc-agent:latest=gcr.io/$PROJECT_ID/tfc-agent:latest
    ```

1. Generate kubeconfig and apply the manifests for Deployment and HorizontalPodAutoscaler.

    ```sh
    $ gcloud container clusters get-credentials $(terraform -raw output cluster_name)
    $ kustomize build . | kubectl apply -f -
    ```

1. Create a workspace or use an existing workspace to attach the Terraform Cloud Agent.
   [More info here](https://developer.hashicorp.com/terraform/cloud-docs/agents/agent-pools#configure-workspaces-to-use-the-agent).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project id to deploy Terraform Cloud Agent | `string` | n/a | yes |
| tfc\_agent\_token | Terraform Cloud agent token. (mark as sensitive) (TFC Organization Settings >> Agents) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ca\_certificate | The cluster ca certificate (base64 encoded) |
| client\_token | The bearer token for auth |
| cluster\_name | Cluster name |
| kubernetes\_endpoint | The cluster endpoint |
| location | Cluster location |
| network\_name | Name of VPC |
| service\_account | The default service account used for running nodes. |
| subnet\_name | Name of VPC |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
