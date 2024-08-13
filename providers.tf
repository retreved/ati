terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

# Define variables
variable "os_auth_url"  	{"http://internalapicloud1.adamhcm.com:5000"}
variable "os_project_name"      {"PROD_ADAM"}
variable "os_region_name"       {"RegionOne"}
variable "os_auth_type"         {"password"}
variable "os_username"          {"joe.cairns"}
variable "os_password"          {""}
variable "flavor_id"            {"i3bf6ae51-4be3-43f6-9b1c-3bd7b0f28034"}
variable "image_id"             {"a2358cac-e95e-4644-9848-ea04f3aadb11"}
variable "key_pair"             {"prodkey"}

# Openstack provider details, can be moved out to providers.tf
provider "openstack" {
  auth_url    = var.os_auth_url 
  project_name = var.os_project_name 
  username   = var.os_username
  password   = var.os_password 
  region = var.os_region_name
  insecure    = true          # Not recommended for production (security risk)
}

# Prompt for password.  This can be removed and the password added above.
variable "openstack_password" {
  type = string
  sensitive = true
}
