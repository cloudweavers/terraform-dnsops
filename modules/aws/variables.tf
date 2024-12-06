variable "cluster_name" {
  description = "The name of the cluster to create a DNS record for."
  type        = string
}

variable "cluster_nodes" {
  description = "The MAC address or serial number of each node in the cluster."
  type        = list(string)
}

variable "cluster_parameters" {
  description = "Key value pairs of parameters to pass to the cluster. Must be uppercase and not contain special characters or a dash."
  type        = map(string)

  validation {
    # Check that all keys are uppercase and do not contain special characters or a dash
    condition = alltrue([for k in keys(var.cluster_parameters) : can(regex("^[A-Z0-9_]+$", k))])
    error_message = "All keys in cluster_parameters must be uppercase and not contain special characters or a dash."
  }
}

variable "domain_name" {
  description = "The domain name to create the DNS record in. Should be in the form example.com"
  type        = string
}

variable "record_ttl" {
  description = "The TTL for the DNS records. Defaults to 300 seconds."
  type        = number
  default     = 300
}

variable "zone_id" {
  description = "The Route53 zone ID to create the DNS records in."
  type        = string
}