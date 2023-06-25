# Copyright (c) HashiCorp, Inc.

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
  required_version = ">= 0.13"
}

provider "kubernetes" {
  host                   = module.tfc-agent-gke.kubernetes_endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.tfc-agent-gke.ca_certificate)
}
