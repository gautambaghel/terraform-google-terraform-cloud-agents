# terraform-google-terraform-cloud-agents

Creates self hosted Terraform Cloud agents on Google Cloud. Using these Terraform modules you can quickly deploy agent pools for your Terraform Cloud workflows.

## [Terraform Cloud agents on GKE](modules/tfc-agent-gke/README.md)

The `tfc-agent-gke` module provisions the resources required to deploy self hosted Terraform Cloud agents on Google Cloud infrastructure using Google Kubernetes Engine (GKE).

This includes

- Enabling necessary APIs
- VPC
- GKE Cluster
- Kubernetes Secret

*Below are some examples:*

- [Simple Terraform Cloud agents on GKE](examples/tfc-agent-gke-simple/README.md) - This example shows how to deploy a simple GKE self hosted Terraform Cloud agent.
- [Custom Terraform Cloud agents on GKE](examples/tfc-agent-gke-custom/README.md) - This example shows how to deploy a custom Terraform Cloud agent image with GKE.

## [Terraform Cloud agents on Managed Instance Groups using VMs](modules/tfc-agent-mig-vm/README.md)

The `tfc-agent-mig-vm` module provisions the resources required to deploy Terrform Cloud agent on Google Cloud infrastructure using Managed Instance Groups.

This includes

- Enabling necessary APIs
- VPC
- NAT & Cloud Router
- Service Account for MIG
- MIG Instance Template
- MIG Instance Manager
- FW Rules
- Secret Manager Secret

Deployment of Managed Instance Groups requires a [Google VM image](https://cloud.google.com/compute/docs/images) with a startup script that downloads and configures the agent or a pre-baked image with the agent installed.

*Below are some examples:*

- [Terraform Cloud agents on MIG VMs](examples/tfc-agent-mig-native-simple/README.md) - This example shows how to deploy a MIG Terraform Cloud agent with startup scripts.

## [Terraform Cloud agents Instance Groups using Container VMs](modules/tfc-agent-mig-container-vm/README.md)

The `tfc-agent-mig-container-vm` module provisions the resources required to deploy Terraform Cloud agents on Google Cloud infrastructure using Managed Instance Groups and Container VMs.

This includes

- Enabling necessary APIs
- VPC
- NAT & Cloud Router
- MIG Container Instance Template
- MIG Instance Manager
- FW Rules

*Below are some examples:*

- [Terraform Cloud agents on MIG Container VMs](examples/tfc-agent-mig-container-vm-simple/README.md) - This example shows how to deploy a Terraform Cloud agent on MIG Container VMs.

## [Configure trust between Terraform and Google Cloud](modules/tfc-oidc/README.md)

The `tfc-oidc` module provisions Workload Identity Pools (WIPs) for authenticating Terraform Cloud to Google Cloud Platform using OpenID Connect protocol (OIDC), an open source standard for verifying identity across different systems.

This includes

- Enabling necessary APIs
- Workload Identity Pool
- Workload Identity Pool Provider
- Service Account Configuration

*Below are some examples:*

- [Terraform Cloud OIDC](examples/oidc-simple/README.md) - This example shows how to configure Workload Identity Federation for a sample Service Account.

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp]

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
