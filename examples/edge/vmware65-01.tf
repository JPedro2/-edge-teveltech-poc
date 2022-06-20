module "vmware65-01" {
    source = "../../modules/edge"
    # Store Number/Location
    location = "vmware65-01"
    # Github Branch
    branch = "dev"
    # List of UUIDs for the devices
    # edge_server = module.vm_store1205.edge_server
    edge_server = [
        {
            name = "scpoc-ubuntu-vm-01"
            uuid = "e35300276bc0"
            control_plane = true
        },
        {
            name = "scpoc-ubuntu-vm-02"
            uuid = "e3d9bd541c9e"
            control_plane = true 
        },
        {
            name = "scpoc-ubuntu-vm-03"
            uuid = "39968873f49e"
            control_plane = true 
        },
                {
            name = "scpoc-ubuntu-vm-04"
            uuid = "6bd57324ba60"
            control_plane = false
        },
        {
            name = "scpoc-ubuntu-vm-05"
            uuid = "ceffa7703c84"
            control_plane = false 
        },
        {
            name = "scpoc-ubuntu-vm-06"
            uuid = "eafe1051d22f"
            control_plane = false 
        }
    ]
    # Profiles to be added
    cluster_profiles = [
        {   name = "Vmware65-infra"
            tag = "1.0.0"
        }
    ]
}
