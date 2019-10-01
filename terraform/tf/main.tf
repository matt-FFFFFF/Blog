terraform {
  required_version = "=0.12.9"

  backend "local" {}
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

data "azuread_service_principal" "afd" {
  application_id = "ad0e1c7e-6d38-4ba4-9efd-0bc77ba9f037"
}

# Included as azurerm_client_config does not return correct data for users
# as opposed to service principals:
# https://github.com/terraform-providers/terraform-provider-azurerm/issues/3234
# Scheduled to be fixed in azurerm 1.35
data "external" "aadaccount" {
  program = ["az", "ad", "signed-in-user", "show", "--query", "{objectId: objectId}", "--output", "json"]
}

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
