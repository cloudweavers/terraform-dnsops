provider "cloudflare" {
  # Set the Cloudflare API token using CLOUDFLARE_API_TOKEN environment variable
}

module "dnsops" {
  source        = "../../"
  cluster_name  = "cf-testcluster"
  cluster_nodes = ["node1", "node2", "node3"]
  cluster_parameters = {
    LABEL        = "My Cool Cloudflare Cluster"
    AUTO_UPGRADE = "NO"
    ALERT_EMAILS = "me@somedomain.com"
  }
  domain_name = var.domain_name
  zone_id     = var.zone_id
}