output "cluster_swarm_node" {
  value = "${join("\n", aws_instance.swarm_node.*.public_ip)}"
}

output "cluster_swarm_master" {
  value = "${join("\n", aws_instance.swarm_manager.*.public_ip)}"
}

output "cluster_swarm_glusterfs" {
  value = "${join("\n", aws_instance.swarm_glusterfs.*.public_ip)}"
}
