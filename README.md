# nodeweaver-dnsops

This repository contains modules and instructions for using Terraform to create the DNS entries necessary for DNSOps with NodeWeaver.

## Modules

The `modules` directory contains module code for Amazon Route 53, Azure DNS, and CloudFlare. Each module directory includes the module code and a basic example that shows how to use the module to provision records for a cluster and its nodes. Each module should be published independently on the Terraform module registry. Instructions for publishing and recommended naming can be found in the README for the modules directory.

