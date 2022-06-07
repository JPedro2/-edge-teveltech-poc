terraform {
  required_version = ">= 0.14.0"

#   required_providers {
#     spectrocloud = {
#       version = "~> 0.7.6"
#       source  = "spectrocloud/spectrocloud"
#     }
#   }
}
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

