# Basic Example for terraform-azurerm-dnsops

This configuration will deploy DNS records to an Azure DNS zone for a basic three node cluster.

## Requirements

To use this module, you will need to update the following argument in the `module` block:

* `cluster_nodes`: Update to the actual serial numbers or MAC addresses of the nodes in your cluster.

You will also need to supply values for the following input variables:

* `domain_name`: The domain name you want to use.
* `resource_group_name`: The Resource Group Name containing your Azure DNS Zone.

If you're using version 4 of the `azurerm` provider, you'll need to set the environment variable `ARM_SUBSCRIPTION_ID` to select the proper Azure subscription.

Use whatever method of Azure authentication you prefer.
