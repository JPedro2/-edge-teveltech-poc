module "vms" {
    source = "../../modules/edge_vm"
    datacenter = "Asgard"
    datastore = "Mjolnir"
    cluster = "Thor"
    resource_pool = "edge"
    instances = 3
    network = { # To use DHCP create Empty list ["",""]; You can also use a CIDR annotation;
        "skunkworks|mgmt|services" = [
            "", 
            "",
            ""
        ] 
    }
    # ipv4submask = ["24","24","24","24","24","24"]
    dns_server_list = ["10.101.128.15","10.101.128.16"]
    vmgateway = "10.239.21.1"
    template_name = "ubuntu-cncf-v1.21.12-13"
    vm_name_prefix = "vms"
    cpu = 4
    memory = 8192
    folder = "edge"
}