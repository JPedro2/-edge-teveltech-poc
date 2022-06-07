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
    path_to_iso = "iso/p6os-opensuse-k3s-v1.21.12-6.iso"
    disk0_size = 30
    disk1_size = 70

}

module "cluster_store1205" {
    source = "../../modules/edge"
    # Store Number/Location
    location = "store1205"
    # Github Branch
    branch = "dev"
    # Device UUIDs to be added
    device_uuid = module.vm_store1205.uuid
    # Profiles to be added
    cluster_profiles = [
        {   name = "store-edge-infra"
            tag = "1.0.0"
            packs = [
                {
                name = "opensuse-k3s"
                tag = "1.21.12-k3s0"
                values = file(local.value_files["k3s_config"].location)
                }
            ]
        },
        {
            name = "store-edge-apps"
            tag = "2.0.0"
        }
    ]
}