variable "datacenter" {}
variable "datastore" {}
variable "cluster" {}
variable "network" {}
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
variable "folder" {}
variable "path_to_iso" {}
variable "disk0_size" {
    type = number
}
variable "disk1_size" {
    type = number
}