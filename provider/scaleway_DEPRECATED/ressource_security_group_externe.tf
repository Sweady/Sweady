resource "scaleway_security_group" "swarm_externe" {
  name = "swarm"
  description = "Security Group for Docker Swarm Cluster"
}

resource "scaleway_security_group_rule" "swarm_externe_http" {
  security_group = "${scaleway_security_group.swarm_externe.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 80
}
resource "scaleway_security_group_rule" "swarm_externe_https" {
  security_group = "${scaleway_security_group.swarm_externe.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 443
}

resource "scaleway_security_group_rule" "swarm_externe_rethinkdb" {
  security_group = "${scaleway_security_group.swarm_externe.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 22
}