resource "azurerm_key_vault" "kv" {
  name                = "kv${random_id.randid.hex}"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "premium"

  tags = var.tags
}

# This is the deployment pipeline service principal
resource "azurerm_key_vault_access_policy" "pipeline" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.service_principal_object_id

  key_permissions = [

  ]

  secret_permissions = [
    "get",
    "set"
  ]

  certificate_permissions = [
    "get",
    "list",
    "create",
    "import",
    "update",
    "delete"
  ]
}

# This is the Azure Front Door object ID. It needs access to retrieve the certificates/secrets.
resource "azurerm_key_vault_access_policy" "afd" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.afd.object_id

  certificate_permissions = [
    "get"
  ]

  secret_permissions = [
    "get"
  ]
}

# # This is the HSM backed key that will wrap the asymmetric key for the Let's Encrypt state store
# resource "azurerm_key_vault_key" "letsencrypt" {
#   name         = "letsencrypt"
#   key_vault_id = azurerm_key_vault.kv.id
#   key_type     = "RSA-HSM"
#   key_size     = 4096

#   key_opts = [
#     "decrypt",
#     "encrypt",
#     "sign",
#     "unwrapKey",
#     "verify",
#     "wrapKey",
#   ]

#   tags = var.tags
# }
