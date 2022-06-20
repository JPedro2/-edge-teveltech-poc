variable "datacenter" {}
variable "datastore" {}
variable "cluster" {}
variable "network" {
  description = "Define PortGroup and IPs/CIDR for each VM. If no CIDR provided, the subnet mask is taken from var.ipv4submask."
  type        = map(list(string))
  default     = {}
}
variable "network_type" {
  description = "Define network type for each network interface."
  type        = list(any)
  default     = null
}
variable "dns_server_list" {
  type    = list(string)
  default = null
}
variable "control_plane" {
  type = list(bool)
}
variable "dns_suffix_list" {
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine."
  type        = list(string)
  default     = null
}
variable "ipv4submask" {
  description = "ipv4 Subnet mask. Warning: The order must follow the alphabetic order from var.network."
  type        = list(any)
  default     = ["24"]
}
variable "vmgateway" {
  description = "VM gateway to set during provisioning."
  default     = null
}
variable "vm_name_prefix" {}
variable "resource_pool" {}
variable "instances" {
    type = number
}
variable "cpu" {
    type = number
}
variable "memory" {
    type = number
}
variable "template_name" {}
variable "folder" {}
variable "content_library" {
  description = "Name of the content library where the OVF template is stored."
  default     = null
}
# variable "path_to_iso" {}
# variable "disk0_size" {
#     type = number
# }
# variable "disk1_size" {
#     type = number
# }
# variable "disk2_size" {
#     type = number
# }