data "spectrocloud_pack" "this" {
  for_each = {
    for pack in var.packs : pack.name => pack
    if pack.type != "manifest"
  }
  name    = each.key
  version = each.value["tag"]
}


resource "spectrocloud_cluster_profile" "this" {
  name        = var.name
  description = var.description
  tags        = var.tags
  cloud       = var.cloud
  type        = var.type

  dynamic "pack" {
    for_each = {
      for pack in var.packs : pack.name => pack
    }

    content {
      name   = pack.value["name"]
      type   = pack.value["type"]
      tag    = pack.value["tag"]
      uid    = pack.value["type"] != "manifest" ? data.spectrocloud_pack.this[pack.key].id : null
      values = pack.value["values"] != null ? pack.value["values"] : data.spectrocloud_pack.this[pack.key].values

      dynamic "manifest" {
        for_each = try({
          for manifest in pack.value["manifests"] : manifest.name => manifest
        }, [])
        content {
          name    = manifest.value["name"]
          content = manifest.value["content"]
        }
      }
    }
  }
}