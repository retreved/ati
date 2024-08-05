
# Define variables 
variable "os_auth_url" 	{"http://internalapicloud1.adamhcm.com:5000"}
variable "os_project_name"	{"PROD_ADAM"}
variable "os_region_name"	{"Region1"}
variable "os_auth_type"		{"password"}
variable "os_username"		{"joe.cairns"}
variable "os_password"		{""}
variable "flavor_id"		{"i3bf6ae51-4be3-43f6-9b1c-3bd7b0f28034"}
variable "image_id"		{"a2358cac-e95e-4644-9848-ea04f3aadb11"}
variable "key_pair"		{"prodkey"}
variable "server_group"		{"production_antiaffinity"}

# Create the anti-affinity server group to be used with this plan
resource "openstack_compute_servergroup_v2" "production-servergroup" {
  name     = var.server_group
  policies = ["anti-affinity"]
}

# Create ProdTASrv server
resource "openstack_compute_instance_v2" "ProdTASrv" {
  name            = "ProdTASrv"
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_name
# security groups are assigned in the ports that will be attached
#  security_groups = ["public_web", "public_ssh", "default"]


# Add server to anti-affinity group
  scheduler_hints {
    group = openstack_compute_servergroup_v2.production-antiaffinity.id
  }

# Attach flaoting/fixed IP port
  network {
    port = "7c333fe6-1ea7-4b0e-b85e-cdc5b8d0f2e0"
  }

# Attach OS volume
  block_device {
    uuid                  = "a2358cac-e95e-4644-9848-ea04f3aadb11"
    source_type           = "image"
    destination_type      = "local"
    boot_index            = 0
    delete_on_termination = true
  }

# Attach data volume
  block_device {
    uuid = "c322ed18-2032-4fa3-92f9-8f3f08ec5063"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=1
  }
}

# Create AllDBServer server
resource "openstack_compute_instance_v2" "ALLDBServer" {
  name            = "ALLDBServer"
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_name
#  security_groups = ["Prod_Ansible", "prod_dbs", "default", "public_ssh", "Prod_Commvault"]

# Add servero to anti-affinity
  scheduler_hints {
    group = openstack_compute_servergroup_v2.production-antiaffinity.id
  }

# Attach floating/fixed IP port
  network {
    port = "a294105d-0448-402a-bce2-a94c7aac9ce3"
  }

# Attach boot OS Volume
  block_device {
    uuid                  = "a2358cac-e95e-4644-9848-ea04f3aadb11"
    source_type           = "image"
    destination_type      = "local"
    boot_index            = 0
    delete_on_termination = true
  }

# Attach Data volume
  block_device {
    uuid = "05bb66e8-199b-4708-bd9c-090318fec2ea"
    source_type = "volume"
    destination_type = "volume"
    boot_index=1
  }
}
