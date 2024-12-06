# Basic Example for terraform-cloudflare-dnsops

This configuration will deploy DNS records to a Cloudflare DNS zone for a basic three node cluster.

## Requirements

To use this module, you will need to update the following argument in the `module` block:

* `cluster_nodes`: Update to the actual serial numbers or MAC addresses of the nodes in your cluster.

You will also need to supply values for the following input variables:

* `domain_name`: The domain name you want to use.
* `zone_id`: The zone ID of your Cloudflare zone.

Use whatever method of AWS authentication you prefer.
