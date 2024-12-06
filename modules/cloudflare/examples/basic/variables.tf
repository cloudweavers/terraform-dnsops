variable "domain_name" {
  description = "The domain name to create the DNS record in. Should be in the form example.com"
  type        = string
}

variable "zone_id" {
  description = "The Route53 zone ID to create the DNS records in."
  type        = string
}