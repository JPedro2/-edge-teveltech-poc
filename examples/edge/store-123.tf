module "store-123" {
    source = "../../modules/edge"


    # Store Number/Location
    location = "store-123"
    
    # Device UUIDs to be added
    device_uuid = [
        "3503E3785D63",
        "15C19AD25160",
        "FFB7EB41D0F9"
    ]
    # Profiles to be added
    infra_profile = "store-edge-infra"
    app_profile = "store-edge-apps"
}