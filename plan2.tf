terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

provider "openstack" {
  auth_url    = "http://internalapicloud1.adamhcm.com:5000"
  tenant_name = "ADAM_PROD"
  user_name   = "joe.cairns"
  password    = ""
  insecure    = true          # Not recommended for production (security risk)
}

# Prompt for password.  This can be removed and the password added above.
variable "openstack_password" {
  type = string
  sensitive = true
}

# Create the anti-affinity server group to be used with this plan
resource "openstack_compute_servergroup_v2" "production-servergroup" {
  name     = "ProdDB-antiaffinity"
  policies = ["anti-affinity"]
}

# Create ProdMSDBServer3 server
resource "openstack_compute_instance_v2" "ProdMSDBServer3" {
  name            = "ProdMSDBServer3"
  image_id        = "a2358cac-e95e-4644-9848-ea04f3aadb11"
  flavor_id       = "3bf6ae51-4be3-43f6-9b1c-3bd7b0f28034"
  key_pair        = "prodkey"
  security_groups = ["Prod_Ansible", "prod_dbs", "default", "public_ssh", "Prod_Commvault"]


  scheduler_hints {
    group = openstack_compute_servergroup_v2.ProdDB-antiaffinity.id
  }

  network {
    port_id = "3492acb0-c787-44d4-9275-dff4b2bd3d8a"
  }

  block_device {
    uuid                  = "a2358cac-e95e-4644-9848-ea04f3aadb11"
    source_type           = "image"
    destination_type      = "local"
    boot_index            = 0
    delete_on_termination = true
  }

  block_device {
    uuid = "c82bc208-56dc-41a3-b984-313df623b80c"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=1
  }

  block_device {
    uuid = "37aeb455-48d8-4e31-b029-7fa4f8c9ec56"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=2
  }

  block_device {
    uuid = "023a2900-cfc0-4579-8026-e1dfb2216ad2"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=3
  }
}

# Create ProdMSDBServer2 server
resource "openstack_compute_instance_v2" "ProdMSDBServer2" {
  name            = "ProdMSDBServer2"
  image_id        = "a2358cac-e95e-4644-9848-ea04f3aadb11"
  flavor_id       = "3bf6ae51-4be3-43f6-9b1c-3bd7b0f28034"
  key_pair        = "prodkey"
  security_groups = ["Prod_Ansible", "prod_dbs", "default", "public_ssh", "Prod_Commvault"]


  scheduler_hints {
    group = openstack_compute_servergroup_v2.ProdDB-antiaffinity.id
  }

# Attach floating IP port
  network {
    port_id = "c289d29f-9b15-410f-b3d7-4598e6438dfb"
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
    uuid = "cb2d1ced-dd8a-4f0b-8ace-ce06ef304de9"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=1
  }

# Attach data volume
  block_device {
    uuid = "d39a8402-0725-4382-82b8-611996ae38dd"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=2
  }

# Attach data volume
  block_device {
    uuid = "1df86c39-be0e-47a1-831c-6ce4f6665128"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=3
  }
}

# Create ProdMSDBServer1 server
resource "openstack_compute_instance_v2" "ProdMSDBServer1" {
  name            = "ProdMSDBServer1"
  image_id        = "a2358cac-e95e-4644-9848-ea04f3aadb11"
  flavor_id       = "3bf6ae51-4be3-43f6-9b1c-3bd7b0f28034"
  key_pair        = "prodkey"
  security_groups = ["Prod_Ansible", "prod_dbs", "default", "public_ssh", "Prod_Commvault"]


  scheduler_hints {
    group = openstack_compute_servergroup_v2.ProdDB-antiaffinity.id
  }

# Attach floating IP port
  network {
    port_id = "397dce8d-4a07-4aa6-910e-773e76d6dac7"
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
    uuid = "3a0abab7-2248-4168-b86b-3f2a7d176140"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=1
  }

# Attach data volume
  block_device {
    uuid = "3a0abab7-2248-4168-b86b-3f2a7d176140"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=2
  }

# Attach data volume
  block_device {
    uuid = "3a0abab7-2248-4168-b86b-3f2a7d176140"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=3
  }
}
