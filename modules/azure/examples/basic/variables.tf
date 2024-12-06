variable "domain_name" {
  description = "The domain name to create the DNS record in. Should be in the form example.com"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group holding the DNS zone."
  type        = string
}