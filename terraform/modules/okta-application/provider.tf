terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 6.0"
    }
  }
}

provider "okta" {
  org_name = var.org_name
  base_url = var.base_url
}