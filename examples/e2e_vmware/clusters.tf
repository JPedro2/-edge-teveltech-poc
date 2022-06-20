# module "cluster_store1205" {
#     source = "../../modules/edge"
#     # Store Number/Location
#     location = "store1205"
#     # Github Branch
#     branch = "dev"
#     # List of UUIDs for the devices
#     # edge_server = module.vm_store1205.edge_server
#     edge_server = [
#         {
#             name = "edge1205-01"
#             uuid = "123456"
#             control_plane = true
#         },
#         {
#             name = "edge1205-02"
#             uuid = "123454"
#             control_plane = false 
#         }
#     ]
#     # Profiles to be added
#     cluster_profiles = [
#         {   name = "store-edge-infra"
#             tag = "1.0.0"
#         }
#     ]
# }
