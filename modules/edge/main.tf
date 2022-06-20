data "spectrocloud_cluster_profile" "this" {
  for_each = {
    for profile in var.cluster_profiles : profile.name => profile
  }
  name = each.key
  version = each.value["tag"]
}
# locals {
#   tags = concat([
#       "imported:false"
#     ], [
#     for k, v in tomap(var.tags) :
#       "${k}:${v}"
#   ])
# }

resource "spectrocloud_appliance" "this" {
  # count = length(var.device_uuid)
  for_each = {for server in var.edge_server: server.name => server}
  # uid = lower("edge-${var.device_uuid[count.index]}")
  uid = lower("edge-${each.value.uuid}")
  labels = {
    "cluster" = spectrocloud_cluster_import.this.id
    # "name" = "edge-${var.location}"
    "name" = each.value.name
    "environment" = var.branch
    "k8s-node-type" = each.value.control_plane == true ? "control-plane" : "worker"
  }
  wait = false
}

resource "spectrocloud_cluster_import" "this" {
  name               = "edge-${var.location}"
  cloud              = "generic"
  # tags = local.tags
  tags = ["imported:false","environment:${var.branch}"]

  dynamic "cluster_profile" {
  
    for_each = var.cluster_profiles
    content {
      id = data.spectrocloud_cluster_profile.this[cluster_profile.value.name].id
      
      dynamic "pack" {
        for_each = cluster_profile.value.packs == null ? [] : cluster_profile.value.packs

        content {
          name = pack.value.name
          tag = pack.value.tag
          values = pack.value.values
          
          # dynamic "manifest" {
          #   for_each = pack.value.manifest== null ? [] : pack.value.manifest
      
          #   content {
          #   name    = manifest.value.name
          #   tag = manifest.value.tag
          #   content = manifest.value.content
          #   }
          # }
        }
      }
    }
    
  }
}