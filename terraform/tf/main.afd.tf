resource "azurerm_frontdoor" "blog" {
  name                                         = "fd${random_id.randid.hex}"
  location                                     = "global"
  resource_group_name                          = azurerm_resource_group.rg.name
  enforce_backend_pools_certificate_name_check = true

  routing_rule {
    name               = "https"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = compact(["azurefd", var.custom_domain.enabled ? replace(var.custom_domain.zone_name, ".", "-") : ""])
    #frontend_endpoints = var.custom_domain.enabled ? [replace(var.custom_domain.zone_name, ".", "-")] : ["azurefd"]
    forwarding_configuration {
      forwarding_protocol                   = "HttpsOnly"
      backend_pool_name                     = "static"
      cache_use_dynamic_compression         = true
      cache_query_parameter_strip_directive = "StripAll"
    }
  }

  routing_rule {
    name               = "https-redirect"
    accepted_protocols = ["Http"]
    patterns_to_match  = ["/*"]
    redirect_configuration {
      custom_host       = var.custom_domain.enabled ? var.custom_domain.record_name == "@" ? var.custom_domain.zone_name : "${var.custom_domain.record_name}.${var.custom_domain.zone_name}" : "${random_id.randid.hex}.azurefd.net"
      redirect_protocol = "HttpsOnly"
      redirect_type     = "Found"
    }
    frontend_endpoints = compact(["azurefd", var.custom_domain.enabled ? replace(var.custom_domain.zone_name, ".", "-") : ""])
    #frontend_endpoints = var.custom_domain.enabled ? [replace(var.custom_domain.zone_name, ".", "-")] : ["azurefd"]
  }

  backend_pool_load_balancing {
    name                            = "fastestresponder"
    sample_size                     = 4
    successful_samples_required     = 2
    additional_latency_milliseconds = 0
  }

  backend_pool_health_probe {
    name                = "httpscheck"
    interval_in_seconds = 30
    path                = "/"
    protocol            = "Https"
  }

  backend_pool {
    name                = "static"
    load_balancing_name = "fastestresponder"
    health_probe_name   = "httpscheck"

    dynamic "backend" {
      for_each = [for a in azurerm_storage_account.webstatic : a.primary_web_host]
      content {
        host_header = backend.value
        address     = backend.value
        http_port   = 80
        https_port  = 443
      }
    }
  }

  frontend_endpoint {
    name                              = "azurefd"
    host_name                         = "fd${random_id.randid.hex}.azurefd.net"
    custom_https_provisioning_enabled = false
    session_affinity_enabled          = false
  }

  dynamic "frontend_endpoint" {
    for_each = var.custom_domain.enabled ? [true] : []
    content {
      name                              = replace(var.custom_domain.zone_name, ".", "-")
      host_name                         = var.custom_domain.record_name == "@" ? var.custom_domain.zone_name : "${var.custom_domain.record_name}.${var.custom_domain.zone_name}"
      custom_https_provisioning_enabled = false
      session_affinity_enabled          = false
    }
  }

  # HACK: depends_on must be a static list so using tags to introduce a conditional dependency
  tags = var.custom_domain.enabled ? azurerm_dns_cname_record.afdverify[0].tags : var.tags
}
