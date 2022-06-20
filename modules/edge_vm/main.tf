data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}
data "vsphere_datastore" "datastore" {
  name         = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_resource_pool" "pool" {
  name = var.resource_pool
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "network" {
  count         = length(var.network)
  name          = keys(var.network)[count.index]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_virtual_machine" "template" {
  count         = var.content_library == null ? 1 : 0
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
locals {
  interface_count     = length(var.ipv4submask) #Used for Subnet handeling
  template_disk_count = var.content_library == null ? length(data.vsphere_virtual_machine.template[0].disks) : 0
}
resource "vsphere_virtual_machine" "this" {
  count = var.instances
  name             = "${var.vm_name_prefix}-${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus = var.cpu
  memory = var.memory
  folder = var.folder
  guest_id         = data.vsphere_virtual_machine.template[0].guest_id
  # scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  nested_hv_enabled = true
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0
  dynamic "network_interface" {
    for_each = keys(var.network) #data.vsphere_network.network[*].id #other option
    content {
      network_id   = data.vsphere_network.network[network_interface.key].id
      adapter_type = var.network_type != null ? var.network_type[network_interface.key] : (var.content_library == null ? data.vsphere_virtual_machine.template[0].network_interface_types[0] : null)
    }
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template[0].id
    customize {
        linux_options {
          host_name = "${var.vm_name_prefix}-${count.index + 1}"
          domain = "chelone.io"
        }      
    dynamic "network_interface" {
        for_each = keys(var.network)
        content {
          ipv4_address = split("/", var.network[keys(var.network)[network_interface.key]][count.index])[0]
          ipv4_netmask = var.network[keys(var.network)[network_interface.key]][count.index] == "" ? null : (
            length(split("/", var.network[keys(var.network)[network_interface.key]][count.index])) == 2 ? (
              split("/", var.network[keys(var.network)[network_interface.key]][count.index])[1]
              ) : (
              length(var.ipv4submask) == 1 ? var.ipv4submask[0] : var.ipv4submask[network_interface.key]
            )
          )
        }
      }
      dns_server_list = var.dns_server_list
      dns_suffix_list = var.dns_suffix_list
      ipv4_gateway    = var.vmgateway
    }
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template[0].disks.0.size
    unit_number = 0
  }
  disk {
    label            = "disk1"
    size             = data.vsphere_virtual_machine.template[0].disks.1.size
    unit_number = 1
  }
  disk {
    label            = "disk2"
    size             = data.vsphere_virtual_machine.template[0].disks.2.size
    unit_number = 2
  }
}