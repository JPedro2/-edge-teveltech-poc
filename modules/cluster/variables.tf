
variable "name" {
  type        = string
  description = "Cluster profile name."
}

variable "account" {
  description = "Portworx AWS account"
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.account)
    error_message = "Account has to be one of 'dev', 'prod'."
  }
}
variable "environment" {
  type        = string
  description = "Environment name for deployment."
}
variable "owner" {
  type        = string
  description = "Owner Name"
}

variable "tags" {
  type        = list(string)
  description = "Tags to be added to the profile.  key:value"
  default     = []
}
variable "sshKeyName" {
  type        = string
  description = "Cloud SSH key name to be added."
}
variable "aws_region" {
  type        = string
  description = "AWS Region to deploy into."
}
variable "flux_environment" {
  type        = string
  description = "Flux Environment to use."
}
variable "flux_branch" {
  type        = string
  description = "Flux Branch to use."
}

variable "gh_password" {
  type        = string
  description = "Github Password"
}
variable "gh_user" {
  type        = string
  description = "Github Username"
}
variable "flux_profile_name" {
  type        = string
  description = "Name of the Flux Palette Profile to use."
}
variable "infra_profile_name" {
  type        = string
  description = "Name of the Infrastructure Palette Profile to use."
}