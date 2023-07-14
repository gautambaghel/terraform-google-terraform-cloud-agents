# Copyright (c) HashiCorp, Inc.

provider "kubernetes" {
  host                   = "https://${module.tfc_agent_cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.tfc_agent_cluster.ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.tfc_agent_cluster.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.tfc_agent_cluster.ca_certificate)
  }
}
