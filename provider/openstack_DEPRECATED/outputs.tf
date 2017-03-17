output "cluster_swarm_node" {
  value = "${join("\n", openstack_compute_floatingip_v2.node_fip.*.address)}"
}

output "cluster_swarm_master" {
  value = "${join("\n", openstack_compute_floatingip_v2.manager_fip.*.address)}"
}

output "cluster_swarm_glusterfs" {
  value = "${join("\n", openstack_compute_floatingip_v2.glusterfs_fip.*.address)}"
}
