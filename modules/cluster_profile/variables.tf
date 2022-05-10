
variable "name" {
  type        = string
  description = "Cluster profile name."
}

variable "description" {
  type        = string
  description = "Cluster profile description."
  default     = ""
}
variable "type" {
  type        = string
  description = "Palette profile type."
  default     = "cluster"
}
variable "cloud" {
  type        = string
  description = "Cloud type for deployment."
  default     = "eks"
}


variable "tags" {
  type        = list(string)
  description = "Tags to be added to the profile.  key:value"
  default     = []
}

variable "packs" {
  type = list(object({
    name   = string
    tag    = string
    type   = string
    values = optional(string)
    manifests = optional(list(object({
      name    = string
      content = string
    })))
  }))
}
