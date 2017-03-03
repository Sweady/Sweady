output "Docker Swarm Manager(s) Public IPs" {
  value = "${join("\n               ", formatlist("%s", split(",", aws_instance.swarm_manager.public_ip)))}"
}

output "Docker Swarm Node(s) Public IPs" {
  value = "${join("\n               ", formatlist("%s", split(",", aws_instance.swarm_node.*.public_ip)))}"
}