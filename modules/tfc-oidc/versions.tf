# Copyright (c) HashiCorp, Inc.

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.53, < 5.0.0"
    }
  }
  required_version = ">= 0.13"
}
