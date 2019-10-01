variable "site_name" {
  type    = string
  default = "dev-mattwhite-blog"
}

variable "resource_group_name" {
  type    = string
  default = "blog-dev"
}

# Locations of the storage accounts containg the web content
variable "content_locations" {
  type = set(string)
  default = [
    "westeurope",
    "northeurope",
    "eastus2",
    "westus2"
  ]
}

# This is where we create the supporting infrastructure, e.g. the resource group & Key Vault
variable "primary_location" {
  type    = string
  default = "westeurope"
}

variable "custom_domain" {
  type = object({
    enabled     = bool
    zone_name   = string
    record_name = string
  })
  default = {
    enabled     = true
    zone_name   = "dev.mattwhite.blog"
    record_name = "@"
  }
}

variable "tags" {
  type = map
  default = {
    provisioned_by = "terraform"
  }
}