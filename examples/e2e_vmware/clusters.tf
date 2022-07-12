module "cluster-04" {
    source = "../../modules/edge"
    # Store Number/Location
    name = "uk4"
    cluster_tags = [
        # "vip:10.239.10.10"
    ]
    # List of UUIDs for the devices
    # edge_server = module.vm_store1205.edge_server
    edge_server = [
        {
            name = "uk4-01"
            uuid = "e1521bd0003f"
            control_plane = true
        }
        # {
        #     name = "uk3-03-02"
        #     uuid = "4d2fff805277"
        #     control_plane = false 
        # },
        # {
        #     name = "uk3-03-03"
        #     uuid = "3a796a26df9f"
        #     control_plane = false
        # }
    ]
    # Profiles to be added
    cluster_profiles = [
        {   name = "edge-ubuntu-k3s-infra"
            tag = "1.0.0"
            packs = [
                {
                    name = "lb-metallb"
                    tag = "0.11.0"
                    values = templatefile(local.value_files["metallb_config"].location, {
                        metalLb_range : "10.239.10.11-10.239.10.13"
                    })
                }
            ]
        },
        {
            name = "edge-apps-base"
            tag = "1.0.0"
        }
    ]
}

