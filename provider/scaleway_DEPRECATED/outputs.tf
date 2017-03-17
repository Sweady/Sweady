output "cluster_swarm_node" {
  value = "${join("\n", scaleway_server.swarm_node.*.public_ip)}"
}

output "cluster_swarm_master" {
  value = "${join("\n", scaleway_server.swarm_manager.*.public_ip)}"
}

output "cluster_swarm_glusterfs" {
  value = "${join("\n", scaleway_server.swarm_glusterfs.*.public_ip)}"
}
