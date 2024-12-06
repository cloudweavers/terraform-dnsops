locals {
  records = join(";", [for k, v in var.cluster_parameters : "${k}='${v}'"])

  # AWS Route 53 TXT record strings have a 255 character limit
  # After which you need to split the string with double quotes
  fixed_records = replace(local.records, "/(.{255})/", "$1\"\"")
}

resource "aws_route53_record" "cluster" {
  zone_id = var.zone_id
  name    = var.cluster_name
  type    = "TXT"
  ttl     = var.record_ttl
  records = [local.fixed_records]

  lifecycle {
    precondition {
      # Check that the record is less or equal that 4000 characters
      condition     = length(local.fixed_records) <= 4000
      error_message = "Total text record length is too long. Submitted length is ${length(local.fixed_records)} characters."
    }
  }
}

resource "aws_route53_record" "nodes" {
  for_each = toset(var.cluster_nodes)
  zone_id  = var.zone_id
  name     = each.key
  type     = "CNAME"
  ttl      = var.record_ttl
  records  = ["${var.cluster_name}.${var.domain_name}"]
}