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
  object_id    = data.azurerm_client_config.current.object_id

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
  key_vault_id = "${azurerm_key_vault.kv.id}"
  tenant_id    = "${data.azurerm_client_config.current.tenant_id}"
  object_id    = "${local.afd_object_id}"

  certificate_permissions = [
    "get"
  ]

  secret_permissions = [
    "get"
  ]
}

resource "azurerm_key_vault_certificate" "letsencrypt" {
  count        = var.custom_domain.enabled ? 1 : 0
  name         = var.custom_domain.record_name == "@" ? "${replace(var.custom_domain.zone_name, ".", "-")}" : "${var.custom_domain.record_name}-${replace(var.custom_domain.zone_name, ".", "-")}"
  key_vault_id = "${azurerm_key_vault.kv.id}"

  certificate {
    contents = "${acme_certificate.certificate[0].certificate_p12}"
  }

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 4096
      key_type   = "RSA"
      reuse_key  = false
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }
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
