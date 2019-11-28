resource "tls_private_key" "private_key" {
  count     = var.custom_domain.enabled ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "acme_registration" "reg" {
  count           = var.custom_domain.enabled ? 1 : 0
  account_key_pem = tls_private_key.private_key[0].private_key_pem
  email_address   = "matt.white@microsoft.com"
}

resource "acme_certificate" "certificate" {
  count = var.custom_domain.enabled ? 1 : 0
  depends_on = [
    azurerm_dns_zone.zone[0],
    azurerm_dns_ns_record.delegation[0]
  ]
  account_key_pem = acme_registration.reg[0].account_key_pem
  key_type        = 4096
  common_name     = var.custom_domain.record_name == "@" ? "${var.custom_domain.zone_name}" : "${var.custom_domain.record_name}.${var.custom_domain.zone_name}"
  #subject_alternative_names = ["www2.example.com"]

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_RESOURCE_GROUP = "${azurerm_resource_group.rg.name}"
    }
  }
}
