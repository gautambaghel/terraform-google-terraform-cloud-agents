# OIDC Simple Example

## Overview

This example showcases how to configure [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation) using the [tfc-oidc module](../../modules/tfc-oidc/README.md) for a sample Service Account.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project id to create WIF pool and example SA | `string` | n/a | yes |
| tfc\_org\_name | Terraform Cloud org name where the WIF pool will be attached | `string` | n/a | yes |
| tfc\_project\_name | Terraform Cloud project name where the WIF pool will be attached | `string` | `"GCP OIDC"` | no |
| tfc\_workspace\_name | Terraform Cloud workspace name where the WIF pool will be attached | `string` | `"gcp-oidc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| pool\_name | Pool name |
| provider\_name | Provider name |
| tfc\_workspace\_name | Terraform Cloud workspace name with OIDC configured |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
