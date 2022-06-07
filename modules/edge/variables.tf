variable "device_uuid" {
    type = list(string)
}

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
            tag = optional(string)
            values = optional(string)
        })))
    }))
}