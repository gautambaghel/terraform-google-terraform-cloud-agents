# Copyright (c) HashiCorp, Inc.

provider "kubernetes" {
  host                   = var.kubernetes_endpoint
  cluster_ca_certificate = base64decode(var.ca_certificate)
  token                  = data.google_client_config.default.access_token
}
