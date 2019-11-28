terraform {
  required_version = "=0.12.16"
  backend "azurerm" {}
}

provider "azurerm" {
  version = "~>1.37"
}

provider "azuread" {
  version = "~>0.6"
}

provider "external" {
  version = "~>1.2"
}

provider "random" {
  version = "~>2.2"
}

provider "acme" {
  version = "~>1.4"
  #server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "tls" {
  version = "~>2.1"
}

module "blog" {
  source = "./modules/blog"

  site_name           = "dev-mattwhite-blog"
  resource_group_name = "blog-dev"
  content_locations = [
    "westeurope",
    "northeurope",
    "eastus2",
    "westus2"
  ]
  primary_location = "westeurope"
  custom_domain = {
    enabled     = true
    zone_name   = "dev.mattwhite.blog"
    record_name = "@"
  }
  tags = {
    provisioned_by = "terraform"
  }
}
