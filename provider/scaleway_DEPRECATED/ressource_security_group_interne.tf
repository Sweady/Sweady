resource "scaleway_security_group" "swarm" {
  name = "swarm"
  description = "Security Group for Docker Swarm Cluster"
}

resource "scaleway_security_group_rule" "swarm_interne_ssh" {
  security_group = "${scaleway_security_group.swarm.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 22
}