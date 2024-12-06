provider "azurerm" {
  features {}
}

module "dnsops" {
  source        = "../../"
  cluster_name  = "mycoolcluster"
  cluster_nodes = ["001A2B3C4D5E", "001A2B3C4D5F", "001A2B3C4D60"]
  cluster_parameters = {
    LABEL        = "My Cool Cluster"
    AUTO_UPGRADE = "NO"
    ALERT_EMAILS = "me@someaddress.com"
  }
  domain_name         = var.domain_name
  resource_group_name = var.resource_group_name
  record_ttl          = 600
}