provider "aws" {
  region = "us-east-1"
}

run "basic" {

  command = apply

  module {
    source = "./examples/basic"
  }
}