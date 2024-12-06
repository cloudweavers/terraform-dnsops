# terraform-aws-dnsops

This module is used to create DNS records on an Amazon Route 53 zone for use with NodeWeaver's [DNSOps feature](https://12.docs.nodeweaver.eu/#/dnsops).

DNSOps relies on a TXT record for the configured DNS domain containing the cluster's configuration parameters in a single, semi-colon delimited string. Each node in the cluster needs a CNAME record corresponding to its serial number or MAC address that points to the cluster's TXT record.

To use the module, you will need a Route 53 Zone already set up in AWS.

Here is a basic example of the module for a cluster named "mycoolcluster" with three nodes in it:

```hcl
module "dnsops" {
  source        = "../../"
  cluster_name  = "mycoolcluster"
  cluster_nodes = ["001A2B3C4D5E", "001A2B3C4D5F", "001A2B3C4D60"]
  cluster_parameters = {
    LABEL        = "My Cool Cluster"
    AUTO_UPGRADE = "NO"
    ALERT_EMAILS = "me@someaddress.com"
  }
  domain_name = "yourdomain.com"
  zone_id     = "SOMEZONEID"

}
```

This example will create a TXT record for `mycoolcluster.yourdomain.com` with the value `LABEL='My Cool Cluster';AUTO_UPGRADE='NO';ALERT_EMAILS='me@someaddress.com'`. It will also create three CNAME records, one for each node, e.g. `001A2B3C4D5E.yourdomain.com` pointing at `mycoolcluster.yourdomain.com`.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster to create a DNS record for. | `string` | n/a | yes |
| <a name="input_cluster_nodes"></a> [cluster\_nodes](#input\_cluster\_nodes) | The MAC address or serial number of each node in the cluster. | `list(string)` | n/a | yes |
| <a name="input_cluster_parameters"></a> [cluster\_parameters](#input\_cluster\_parameters) | Key value pairs of parameters to pass to the cluster. Must be uppercase and not contain special characters or a dash. | `map(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name to create the DNS record in. Should be in the form example.com | `string` | n/a | yes |
| <a name="input_record_ttl"></a> [record\_ttl](#input\_record\_ttl) | The TTL for the DNS records. Defaults to 300 seconds. | `number` | `300` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The Route53 zone ID to create the DNS records in. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->