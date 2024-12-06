locals {
  records = join(";", [for k, v in var.cluster_parameters : "${k}='${v}'"])
}

resource "cloudflare_record" "cluster" {
  zone_id = var.zone_id
  name    = var.cluster_name
  type    = "TXT"
  ttl     = var.record_ttl
  content = local.records

  lifecycle {
    precondition {
      # Check that the record is less or equal that 4000 characters
      condition     = length(local.records) <= 4000
      error_message = "Total text record length is too long. Submitted length is ${length(local.records)} characters."
    }
  }
}

resource "cloudflare_record" "nodes" {
  for_each = toset(var.cluster_nodes)
  zone_id  = var.zone_id
  name     = each.key
  type     = "CNAME"
  ttl      = var.record_ttl
  content  = "${var.cluster_name}.${var.domain_name}"
}