module "vm_store1205" {
    source = "../../modules/edge_vm"
    datacenter = "Thor"
    datastore = "Mjolnir"
    cluster = "Thor"
    resource_pool = "edge"
    network = "skunkworks|mgmt|services"
    vm_name_prefix = "store1205"
    instances = 3
    cpu = 4
    memory = 8192
    folder = "edge"
    path_to_iso = "iso/p6os-ubuntu-cncf-v1.21.12-1.iso"
    disk0_size = 30
    disk1_size = 100
    disk2_size = 64
}

# module "vm_store1206" {
#     source = "../../modules/edge_vm"
#     datacenter = "Thor"
#     datastore = "Mjolnir"
#     cluster = "Thor"
#     resource_pool = "edge"
#     network = "skunkworks|mgmt|services"
#     vm_name_prefix = "store1206"
#     instances = 3
#     cpu = 4
#     memory = 8192
#     folder = "edge"
#     path_to_iso = "iso/p6os-opensuse-k3s-v1.21.12-6.iso"
#     disk0_size = 30
#     disk1_size = 100
#     disk2_size = 64
# }

# module "vm_store1207" {
#     source = "../../modules/edge_vm"
#     datacenter = "Thor"
#     datastore = "Mjolnir"
#     cluster = "Thor"
#     resource_pool = "edge"
#     network = "skunkworks|mgmt|services"
#     vm_name_prefix = "store1207"
#     instances = 3
#     cpu = 4
#     memory = 8192
#     folder = "edge"
#     path_to_iso = "iso/p6os-opensuse-k3s-v1.21.12-6.iso"
#     disk0_size = 30
#     disk1_size = 100
#     disk2_size = 64
# }
