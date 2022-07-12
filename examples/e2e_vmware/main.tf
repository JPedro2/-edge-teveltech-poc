terraform {
  required_version = ">= 0.14.0"

  required_providers {
    spectrocloud = {
      version = "=0.8.3"
      source  = "spectrocloud/spectrocloud"
    }
  }
}
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
provider "spectrocloud" {
  host         = var.sc_host
  api_key      = var.sc_api_key
  project_name = var.sc_project_name
}
