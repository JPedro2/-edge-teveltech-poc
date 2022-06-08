module "cluster_store1205" {
    source = "../../modules/edge"
    # Store Number/Location
    location = "store1205"
    # Github Branch
    branch = "dev"
    # Device UUIDs to be added
    device_uuid = [
        "8e4f1c2f85d4",
        "f0a369109712",
        "33426b57d3ee" 
    ]
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