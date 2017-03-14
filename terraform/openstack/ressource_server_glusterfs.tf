resource "openstack_compute_floatingip_v2" "glusterfs_fip" {
  count  = "${var.swarm_glusterfs}"
  pool   = "public"
  region = "fr1"
}

resource "openstack_blockstorage_volume_v2" "gluster_vdb" {
  count  = "${var.swarm_glusterfs}"
  name = "gluster_vdb-${count.index + 1}"
  size = 50
  region = "fr1"
}

resource "openstack_compute_instance_v2" "glusterfs_instances" {
  count           = "${var.swarm_glusterfs}"
  name            = "swarm_glusterfs-${count.index + 1}"
  image_name      = "Ubuntu 16.04"
  flavor_id       = "18"
  key_pair        = "cloudwatt"
  region          = "fr1"
  security_groups = ["default"]
  floating_ip     = "${element(openstack_compute_floatingip_v2.glusterfs_fip.*.address, count.index)}"

  network {
    name = "default"
  }

  volume {
    volume_id = "${element(openstack_blockstorage_volume_v2.gluster_vdb.*.id, count.index)}"
  }

  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook -i '${self.access_ip_v4},' --private-key ${var.scw_ssh_key}  '../../ansible/swarm_glusterfs.ansible.yaml' -T 300 --user=cloud"
  }
}