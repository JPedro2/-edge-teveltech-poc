module "well-01" {
    source = "../../modules/edge"
    name = "well-01"
    edge_server = [
        {
            name = "well-edge-01"
            uuid = "48210b2e281e"
            control_plane = true
        },
        {
            name = "well-edge-02"
            uuid = "48210b2e276d"
            control_plane = true 
        }
    ]
    # Profiles to be added
    cluster_profiles = [
        {   name = "store-edge-infra"
            tag = "1.0.0"
        },
        {   name = "store-edge-apps-base"
            tag = "1.5.0"
        }
    ]
}
