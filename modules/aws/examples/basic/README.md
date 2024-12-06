# Basic Example for terraform-aws-dnsops

This configuration will deploy DNS records to a Route 53 zone for a basic three node cluster.

## Requirements

To use this module, you will need to update the following argument in the `module` block:

* `cluster_nodes`: Update to the actual serial numbers or MAC addresses of the nodes in your cluster.

You will also need to supply values for the following input variables:

* `domain_name`: The domain name you want to use.
* `zone_id`: The zone ID of your Amazon Route 53 zone.

You can find your zone ID in the AWS console, or by running the following AWS CLI command:

`PowerShell`

```powershell
# Note the trailing period on the zone name
(aws route53 list-hosted-zones --query "HostedZones[?Name=='yourhostedzone.com'].Id" --output text) -split '/' | Select-Object -Last 1
```

`Bash`

```bash
# Note the trailing period on the zone name
aws route53 list-hosted-zones --query "HostedZones[?Name=='yourhostedzone.com.'].Id" --output text | awk -F'/' '{print $3}'
```

Use whatever method of AWS authentication you prefer.
