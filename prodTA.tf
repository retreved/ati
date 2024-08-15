# Create ProdTASrv server
resource "openstack_compute_instance_v2" "ProdTASrv" {
  name            = "ProdTASrv"
  flavor_id       = var.flavor_id
  key_pair        = var.key_name
  stop_before_destroy = true


# Add server to anti-affinity group
  scheduler_hints {
    group = openstack_compute_servergroup_v2.production-antiaffinity.id
  }

# Attach fixed IP port
# Port already contains secruity groups
  network {
    port = "7c333fe6-1ea7-4b0e-b85e-cdc5b8d0f2e0"
  }

# Attach floating IP port
  network {
    port = "4f4737fb-1163-40c7-bc98-92720fc6ccd6""
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
