provider "azurerm" {
  features {}
}

run "basic" {

  command = apply

  module {
    source = "./examples/basic"
  }
}