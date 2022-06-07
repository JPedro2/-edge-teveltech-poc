module "washington" {
    source = "../../modules/edge_vm"
    datacenter = "Thor"
    datastore = "Mjolnir"
    cluster = "Thor"
    network = "skunkworks|mgmt|services"
    vm_name_prefix = "washington"
    instances = 2
    cpu = 4
    memory = 8192
    folder = "edge"
    path_to_iso = "iso/p6os-opensuse-k3s-v1.21.12-6.iso"
    disk0_size = 30
    disk1_size = 70

}