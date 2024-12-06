provider "azurerm" {
  features {}
}

run "basic" {

  command = plan

  module {
    source = "./examples/basic"
  }
}

run "longstring" {

  command = plan

  variables {
    cluster_name  = "mycoolcluster"
    cluster_nodes = ["001A2B3C4D5E", "001A2B3C4D5F", "001A2B3C4D60"]
    cluster_parameters = {
      LABEL        = "My Cool Cluster"
      AUTO_UPGRADE = "NO"
      ALERT_EMAILS = "me@someaddress.com"
      BOOT_SCRIPT  = file("./tests/files/reallylongstring.txt")
    }
  }

  expect_failures = [
    azurerm_dns_txt_record.main,
  ]
}

run "badparams" {
  
    command = plan
  
    variables {
      cluster_name  = "mycoolcluster"
      cluster_nodes = ["001A2B3C4D5E", "001A2B3C4D5F", "001A2B3C4D60"]
      cluster_parameters = {
        LABel        = "My Cool Cluster"
        AUTO-UPGRADE = "NO"
        "ALERTEMAILS()" = "me@someaddress.com"
      }
    }

    expect_failures = [
      var.cluster_parameters,
    ]
}