resource "openstack_compute_floatingip_v2" "manager_fip" {
  pool   = "public"
  region = "${var.openstack_region}"
  count = "1"
}

resource "openstack_compute_instance_v2" "manager_instances" {
  name            = "swarm_manager"
  image_name      = "Ubuntu 16.04"
  flavor_id       = "18"
  key_pair        = "${var.openstack_name_sshkey}"
  region          = "${var.openstack_region}"
  security_groups = ["default"]
  floating_ip     = "${openstack_compute_floatingip_v2.manager_fip.address}"
  count = "1"

  network {
    name = "default"
  }

  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook -i '${openstack_compute_floatingip_v2.manager_fip.address},' --private-key ${var.scw_ssh_key}  '../../ansible/swarm_manager.ansible.yaml' -T 300 --user=cloud"
  }
}
