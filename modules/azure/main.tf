locals {
  records = join(";", [for k, v in var.cluster_parameters : "${k}='${v}'"])
}

resource "azurerm_dns_txt_record" "main" {
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  zone_name           = var.domain_name
  ttl                 = var.record_ttl

  record {
    value = local.records
  }

  lifecycle {
    precondition {
      # Check that the record is less or equal that 4000 characters
      condition     = length(local.records) <= 4000
      error_message = "Total text record length is too long. Submitted length is ${length(local.records)} characters."
    }
  }

}

resource "azurerm_dns_cname_record" "main" {
  for_each            = toset(var.cluster_nodes)
  name                = each.key
  zone_name           = var.domain_name
  resource_group_name = var.resource_group_name
  ttl                 = var.record_ttl
  record              = "${var.cluster_name}.${var.domain_name}"
}