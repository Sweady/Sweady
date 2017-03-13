resource "openstack_compute_floatingip_v2" "node_fip" {
  count  = "${var.swarm_nodes}"
  pool   = "public"
  region = "fr1"
}

resource "openstack_compute_instance_v2" "node_instances" {
  count           = "${var.swarm_nodes}"
  name            = "swarm_node-${count.index + 1}"
  image_name      = "Ubuntu 16.04"
  flavor_id       = "18"
  key_pair        = "cloudwatt"
  region          = "fr1"
  security_groups = ["default"]
  floating_ip     = "${element(openstack_compute_floatingip_v2.node_fip.*.address, count.index)}"

  network {
    name = "default"
  }

  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook -i '${self.access_ip_v4},' --private-key ${var.scw_ssh_key}  '../../ansible/swarm_node.ansible.yaml' -T 300 --user=cloud"
  }
}