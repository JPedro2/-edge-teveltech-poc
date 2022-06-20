


module "vm_store1205" {
    source = "../../modules/edge_vm"
    datacenter = "Thor"
    datastore = "Mjolnir"
    cluster = "Thor"
    resource_pool = "edge"
    instances = 3
    network = { # To use DHCP create Empty list ["",""]; You can also use a CIDR annotation;
        "skunkworks|k8s|dev" = [
            "10.239.21.21", 
            "10.239.21.22", 
            "10.239.21.23",
            # "10.239.21.24", 
            # "10.239.21.25", 
            # "10.239.21.26"
        ] 
    }
    # ipv4submask = ["24","24","24","24","24","24"]
    control_plane = [
        true,
        true,
        true,
        # true,
        # false,
        # false
    ]
    dns_server_list = ["10.101.128.15","10.101.128.16"]
    vmgateway = "10.239.21.1"
    template_name = "p6os-ubuntu-cncf-1.21.12"
    vm_name_prefix = "store1205"
    cpu = 4
    memory = 8192
    folder = "edge"
    # path_to_iso = "iso/p6os-ubuntu-cncf-v1.21.12-1.iso"
    # disk0_size = 30
    # disk1_size = 64
    # disk2_size = 100
}

