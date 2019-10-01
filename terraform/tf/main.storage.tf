resource "azurerm_storage_account" "webstatic" {
  name                              = substr(lower("sto${random_id.randid.hex}${each.key}"), 0, 24)
  for_each                          = var.content_locations
  location                          = each.key
  resource_group_name               = azurerm_resource_group.rg.name
  account_replication_type          = "ZRS"
  account_tier                      = "Standard"
  account_kind                      = "StorageV2"
  access_tier                       = "Hot"
  enable_https_traffic_only         = true
  enable_blob_encryption            = true
  enable_file_encryption            = true
  enable_advanced_threat_protection = true
  account_encryption_source         = "Microsoft.Storage"

  # HACK: until terraform supports setting service properties
  # https://github.com/tombuildsstuff/giovanni/issues/17
  provisioner "local-exec" {
    command = "az storage blob service-properties update --account-name ${substr(lower("sto${random_id.randid.hex}${each.key}"), 0, 24)} --static-website  --index-document index.html --404-document 404.html"
  }

  tags = var.tags
}

resource "azurerm_storage_account" "config" {
  name                              = substr(lower("sto${random_id.randid.hex}config"), 0, 24)
  location                          = azurerm_resource_group.rg.location
  resource_group_name               = azurerm_resource_group.rg.name
  account_replication_type          = "ZRS"
  account_tier                      = "Standard"
  account_kind                      = "StorageV2"
  access_tier                       = "Hot"
  enable_https_traffic_only         = true
  enable_blob_encryption            = true
  enable_file_encryption            = true
  enable_advanced_threat_protection = true
  account_encryption_source         = "Microsoft.Storage"

  tags = var.tags
}
