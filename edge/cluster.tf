module "cluster-04" {
    source = "../../modules/edge"
    # Store Number/Location
    name = "teveltech-poc-1"
    # cluster_tags = [
    #     "vip:10.239.10.10"
    # ]
    # node_labels = {
    #     location = "pittsburgh"
    # }
    # List of UUIDs for the devices
    edge_server = [
        # {
        #     name = "uk4-01"
        #     uuid = "e1521bd0003f"
        #     control_plane = true
        # },
        # {
        #     name = "uk3-03-02"
        #     uuid = "4d2fff805277"
        #     control_plane = false 
        # },
        {
            name = "teveltech-server-1"
            uuid = "fa0a6ad61f00"
            control_plane = true
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
            name = "ubuntu-k3s-infra"
            tag = "1.0.0"
        }
    ]
}