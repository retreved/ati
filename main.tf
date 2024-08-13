# Create the anti-affinity server group to be used with this plan
resource "openstack_compute_servergroup_v2" "ProductionTA-servergroup" {
  name     = ProductionTA-servergroup
  policies = ["anti-affinity"]
}

# Create ProdTASrv server
resource "openstack_compute_instance_v2" "ProdTASrv" {
  name            = "ProdTASrv"
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_name
  stop_before_destroy = true


# Add server to anti-affinity group
  scheduler_hints {
    group = openstack_compute_servergroup_v2.productionTA-antiaffinity.id
  }

# Attach floating/fixed IP port
# Port already contains secruity groups
  network {
    port = "7c333fe6-1ea7-4b0e-b85e-cdc5b8d0f2e0"
  }

# Attach OS volume
  block_device {
    uuid                  = "9d19ad85-35b0-4b5e-b0fa-b37d50df54e6"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = false
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
  stop_before_destroy = true

# Add server to anti-affinity
  scheduler_hints {
    group = openstack_compute_servergroup_v2.productionDB-servergroup.id
  }

# Attach floating/fixed IP port
# Port already contains secruity groups
  network {
    port = "a294105d-0448-402a-bce2-a94c7aac9ce3"
    delete_on_termination = false
  }

# Attach boot OS Volume
  block_device {
    uuid                  = "5294e526-d81c-4026-8068-0503adb6a434"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = false
  }

# Attach Data volume
  block_device {
    uuid = "05bb66e8-199b-4708-bd9c-090318fec2ea"
    source_type = "volume"
    destination_type = "volume"
    boot_index=1
    delete_on_termination = false
  }
}

# Create ProdMSDBServer3 server
resource "openstack_compute_instance_v2" "ProdMSDBServer3" {
  name            = "ProdMSDBServer3"
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_name
  stop_before_destroy = true


  scheduler_hints {
    group = openstack_compute_servergroup_v2.ProductionDB-servergroup.id
  }

# Attach floating/fixed IP port
# Port already contains secruity groups
  network {
    port = "3492acb0-c787-44d4-9275-dff4b2bd3d8a"
  }

  block_device {
    uuid                  = "699afaea-2b1e-4d1f-bf3a-2b4e47308a12"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = false
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
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_name
  stop_before_destroy = true

  scheduler_hints {
    group = openstack_compute_servergroup_v2.ProductionDB-servergroup.id
  }

# Attach floating IP port
# Port already contains secruity groups
  network {
    port = "c289d29f-9b15-410f-b3d7-4598e6438dfb"
  }

# Attach OS volume
  block_device {
    uuid                  = "ac3a0449-3933-43d7-886b-b5ec576339b2"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = false
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
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_name
  stop_before_destroy = true

  scheduler_hints {
    group = openstack_compute_servergroup_v2.ProdDB-antiaffinity.id
  }

# Attach floating IP port
# Port already contains secruity groups
  network {
    port = "397dce8d-4a07-4aa6-910e-773e76d6dac7"
    delete_on_termination = false
  }

# Attach OS volume
  block_device {
    uuid                  = "f8ad4e59-d259-456b-959e-f49a23bebe7c"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = false
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
    uuid = "eef72826-3543-48cd-a784-25d2ea7f1daf"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=2
  }

# Attach data volume
  block_device {
    uuid = "9587a4c1-7885-4b29-bd26-d3086efcdd76"
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = false
    boot_index=3
  }
}
