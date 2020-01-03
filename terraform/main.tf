terraform {
  required_version = "=0.12.18"
  backend "azurerm" {}
}

provider "azurerm" {
  version = "~>1.39"
}

provider "azuread" {
  version = "~>0.7"
}

provider "external" {
  version = "~>1.2"
}

provider "random" {
  version = "~>2.2"
}

provider "acme" {
  version = "~>1.5"
  #server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "tls" {
  version = "~>2.1"
}

# Read in the parent DNS zone so that we can create the delegation
data "azurerm_dns_zone" "parent" {
  name                = "mattwhite.blog"
  resource_group_name = "blog"
}

module "blog" {
  source = "./modules/terraform-azurerm-frontdoorstaticwebsite"

  site_name           = "dev-mattwhite-blog"
  resource_group_name = "blog-dev"
  content_locations = [
    "westeurope",
    "northeurope",
    "eastus2",
    "westus2"
  ]
  primary_location = "westeurope"
  parent_domain = data.azurerm_dns_zone.parent
  custom_domain = {
    enabled     = true
    zone_name   = "dev.mattwhite.blog"
    record_name = "@"
  }
  tags = {
    provisioned_by = "terraform"
  }
}
