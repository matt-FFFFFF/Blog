terraform {
  required_version = "=0.12.9"

  backend "azurerm" {}
}

provider "azurerm" {
  version = "~>1.34"
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
  version    = "~>1.4"
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

provider "tls" {
  version = "~>2.1"
}

# Hard coded here due to service principals not having graphapi access to read all objects
# Otherwise could look up applicaiton_id as described here:
# https://docs.microsoft.com/en-us/azure/frontdoor/front-door-custom-domain-https
locals {
  afd_object_id = "21bf1420-2ed9-48b9-bf6d-ece1337d4fd1"
}

# Included as azurerm_client_config does not return correct data for users
# as opposed to service principals:
# https://github.com/terraform-providers/terraform-provider-azurerm/issues/3234
# Scheduled to be fixed in azurerm 1.35
# data "external" "aadaccount" {
#   program = ["az", "ad", "signed-in-user", "show", "--query", "{objectId: objectId}", "--output", "json"]
# }

data "azurerm_client_config" "current" {}

resource "random_id" "randid" {
  byte_length = 6
  keepers = {
    rgname = "${var.resource_group_name}"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${random_id.randid.keepers.rgname}"
  location = var.primary_location

  tags = var.tags
}
