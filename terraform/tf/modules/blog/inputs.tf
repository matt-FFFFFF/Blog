variable "site_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

# Locations of the storage accounts containg the web content
variable "content_locations" {
  type = set(string)
}

# This is where we create the supporting infrastructure, e.g. the resource group & Key Vault
variable "primary_location" {
  type = string
}

variable "custom_domain" {
  type = object({
    enabled     = bool
    zone_name   = string
    record_name = string
  })
}

variable "tags" {
  type = map
  default = {
    provisioned_by = "terraform"
  }
}
