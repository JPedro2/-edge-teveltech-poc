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
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
resource "vsphere_virtual_machine" "this" {
  count = var.instances
  name             = "${var.vm_name_prefix}-${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus = var.cpu
  memory = var.memory
  folder = var.folder
  guest_id         = "ubuntu64Guest"
  nested_hv_enabled = true
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  cdrom {
      datastore_id = data.vsphere_datastore.datastore.id
      path = var.path_to_iso
  }
    disk {
    label       = "disk0"
    size        = var.disk0_size
  }
  disk {
    label       = "disk1"
    size        = var.disk1_size
    unit_number = 1
  }
}