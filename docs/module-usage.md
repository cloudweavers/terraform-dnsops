# Deploying DNSOps with Terraform

Terraform is a popular Infrastructure as Code (IaC) tool used to provision and manage infrastructure across multiple public cloud providers and platform services. It has become the tool of choice for many DevOps and networking teams.

NodeWeaver has written three Terraform modules to assist in setting up DNSOps by creating the necessary `TXT` and `CNAME` records for a NodeWeaver cluster using DNSOps for configuration. Each module supports a different DNS provider- currently Amazon Route 53, Azure DNS, and Cloudflare DNS. The input variables for each module have been kept consistent except where provider specific information is required.

The modules along with usage instructions can be found on the Terraform public registry:

* [Amazon Route 53](TBD)
* [Azure DNS](TBS)
* [Cloudflare DNS](TBS)

Below is a general guide to using the modules.

## Prerequisites

* **DNS Provider Account**: To use each module, you must first have an account on the target DNS provider and credentials for authentication. Please refer to the specific provider documentation for more information on authentication options.
* **DNS Provider Zone**: You also must have an existing DNS zone you wish to use for DNSOps. The Terraform modules do not create the DNS zone, they only add records to an existing zone.
* **MAC Addresses for Cluster Nodes**: For each node in the cluster, a `CNAME` record will be created using the MAC address or serial number of the node for resolution of the cluster's `TXT` record.
* **Parameter Settings**: For the cluster, you will need a list of parameters and values you wish to configure for the cluster. This list can be updated after the initial deployment.

## Using the Modules

As mentioned previously, each module is provider specific, so there will be small variations in the input variables for the module. The example below is for an Amazon Route 53 zone named `mycooldomain.com` for the cluster called `my-nice-cluster` with parameters set for `LABEL`, `AUTO_UPGRADE`, and `ALERT_EMAILS`.

```hcl
module "dnsops" {
  source        = "TODO"
  version       = "1.0.0"

  cluster_name       = "my-nice-cluster"
  cluster_nodes      = ["001A2B3C4D5E", "001A2B3C4D5F", "001A2B3C4D60"]
  cluster_parameters = {
    LABEL        = "My Nice Cluster"
    AUTO_UPGRADE = "NO"
    ALERT_EMAILS = "alerts@mycooldomain.com"
  }

  domain_name = "mycooldomain.com"
  zone_id     = "<ROUTE53_SPECIFIC_ZONE_ID>"

}
```

This module block will create one `TXT` record for the cluster and three `CNAME` records, one for each node in the cluster.

The parameters will be combined into a single string for the `TXT` record. Parameter names **must** be all uppercase with no special characters besides an underscore (`_`). You should **not** include single quotation marks (`'`) for the parameter values.

### Module arguments

The cluster specific arguments are the same for each DNS provider. Below is a table of each input variable and its description:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `input_cluster_name` | The name of the cluster to create a DNS record for. | `string` | n/a | yes |
| `input_cluster_nodes` | The MAC address or serial number of each node in the cluster. | `list(string)` | n/a | yes |
| `input_cluster_parameters` | Key value pairs of parameters to pass to the cluster. Must be uppercase and not contain special characters or a dash. | `map(string)` | n/a | yes |
| `input_domain_name `| The domain name to create the DNS record in. Should be in the form example.com | `string` | n/a | yes |
| `input_record_ttl` | The TTL for the DNS records. Defaults to 300 seconds. | `number` | `300` | no |

### Module differences

The arguments for each module vary by cloud provider. All cluster specific arguments are the same. The following is a table of provider specific arguments:

| Provider | Argument | Description |
| -------- | -------- | ----------- |
| Route 53 | `zone_id` | The Zone ID associated with the hosted zone in AWS. |
| Azure DNS | `resource_group_name` | The resource group in Azure containing the DNZ zone resource |
| Cloudflare DNS | `zone_id` | The Zone ID associated with the registered domain in Cloudflare. |

The team managing your DNS provider should be able to furnish the values for these arguments.
