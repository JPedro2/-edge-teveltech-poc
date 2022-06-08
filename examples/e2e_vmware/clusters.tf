module "cluster_store1205" {
    source = "../../modules/edge"
    # Store Number/Location
    location = "store1205"
    # Github Branch
    branch = "dev"
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
            packs = [
                {
                    name = "spectro-byo-manifest"
                    tag = "1.0.0"
                    values = templatefile(local.value_files["argo_hipster_config"].location, {
                        branch : "dev"
                    })
                },
                {
                    name = "lb-metallb"
                    tag = "0.11.0"
                    values = templatefile(local.value_files["metallb_config"].location, {
                        metalLb_range : "10.239.10.18 - 10.239.10.20"
                    })
                }
            ]
        }
    ]
}

module "cluster_store1206" {
    source = "../../modules/edge"
    # Store Number/Location
    location = "store1206"
    # Github Branch
    branch = "prod"
    device_uuid = module.vm_store1206.uuid
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
            packs = [
                {
                    name = "spectro-byo-manifest"
                    tag = "1.0.0"
                    values = templatefile(local.value_files["argo_hipster_config"].location, {
                        branch : "main"
                    })
                },
                {
                    name = "lb-metallb"
                    tag = "0.11.0"
                    values = templatefile(local.value_files["metallb_config"].location, {
                        metalLb_range : "10.239.10.21 - 10.239.10.23"
                    })
                }
            ]
        }
    ]
}