# Create AllDBServer server
resource "openstack_compute_instance_v2" "ALLDBServer" {
  name            = "ALLDBServer"
  flavor_id       = var.flavor_id
  key_pair        = var.key_name
  stop_before_destroy = true

# Add server to anti-affinity
  scheduler_hints {
    group = openstack_compute_servergroup_v2.production-antiaffinity.id
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
