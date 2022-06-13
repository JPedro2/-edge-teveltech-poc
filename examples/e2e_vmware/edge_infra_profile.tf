# module "store-edge-infra" {
#   source = "../../modules/cluster_profile"

#   name        = "store-edge-infra"
#   description = "Cluster Profile for Store K8s Infrastructure"
#   type        = "add-on"
#   cloud = "all"

#   packs = [
#     {
#       name = "opensuse-k3s"
#       tag  = "1.21.12-k3s0"
#       type = "spectro"
#     },
#     # {
#     #   name   = "spectro-proxy"
#     #   tag    = "1.0.0"
#     #   type   = "spectro"
#     # },
#     # {
#     #   name = "kubevirt"
#     #   tag  = "0.51.0"
#     #   type = "spectro"
#     # },
#     {
#       name = "suc"
#       tag  = "0.8.0"
#       type = "spectro"
#     }

#   ]
# }