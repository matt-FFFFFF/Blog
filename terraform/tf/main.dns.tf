# Read in the parent DNS zone so that we can create the delegation
data "azurerm_dns_zone" "parent" {
  name                = "mattwhite.blog"
  resource_group_name = "blog"
}

resource "azurerm_dns_zone" "zone" {
  count               = var.custom_domain.enabled ? 1 : 0
  name                = var.custom_domain.zone_name
  resource_group_name = azurerm_resource_group.rg.name

  tags = var.tags
}

resource "azurerm_dns_cname_record" "afdverify" {
  count               = var.custom_domain.enabled ? 1 : 0
  name                = "afdverify"
  zone_name           = azurerm_dns_zone.zone[0].name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 60
  record              = "afdverify.fd${random_id.randid.hex}.azurefd.net"

  tags = var.tags
}

# Create DNS delegation from the parent zone
resource "azurerm_dns_ns_record" "delegation" {
  count               = var.custom_domain.enabled ? 1 : 0
  name                = split(".", "${var.custom_domain.zone_name}")[0]
  zone_name           = "${data.azurerm_dns_zone.parent.name}"
  resource_group_name = "${data.azurerm_dns_zone.parent.resource_group_name}"
  ttl                 = 300

  records = azurerm_dns_zone.zone[0].name_servers

  tags = var.tags
}
