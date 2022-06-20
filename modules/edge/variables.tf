# variable "device_uuid" {
#     type = list(string)
# }
variable "edge_server" {
    type = list(object({
        name = string
        uuid = string
        control_plane = bool
    }))
}
# variable "tags" {
#   type = object({
#     state = string
#     city = string
#     type = string
#     latlng = string
#     stage = string
#   })
# }
variable "location" {
    type = string
}
variable "branch" {
    type = string
}
variable "cluster_profiles" {
    type = list(object({
        name = string
        tag = optional(string)
        packs = optional(list(object({
            name = string
            tag = string
            values = optional(string)
            manifest = optional(list(object({
                name = string
                tag = string
                content = string
            })))
        })))
    }))
}