provider "cloudflare" {}

run "basic" {

  command = apply

  module {
    source = "./examples/basic"
  }
}