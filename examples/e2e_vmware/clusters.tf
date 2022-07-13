module "cluster-04" {
    source = "../../modules/edge"
    # Store Number/Location
    name = "pedro01"
    cluster_tags = [
        # "vip:10.239.10.10"
    ]
    node_labels = {
        location = "pittsburgh"
    }
    # List of UUIDs for the devices
    edge_server = [
        {
            name = "pedro-01"
            uuid = "ba44dc2a1157"
            control_plane = true
        },
        {
            name = "pedro-02"
            uuid = "b7d889de2c94"
            control_plane = false 
        },
        {
            name = "pedro-03"
            uuid = "d6de7b7ff073"
            control_plane = false
        }
    ]
    # Profiles to be added
    cluster_profiles = [
        # {   name = "edge-ubuntu-k3s-infra"
        #     tag = "1.0.0"
        #     packs = [
        #         {
        #             name = "lb-metallb"
        #             tag = "0.11.0"
        #             values = templatefile(local.value_files["metallb_config"].location, {
        #                 metalLb_range : "10.239.10.11-10.239.10.13"
        #             })
        #         }
        #     ]
        # },
        {
            name = "ubuntu-cncf"
            tag = "1.0.0"
        }
    ]
}

