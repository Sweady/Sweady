
resource "scaleway_server" "swarm_node" {
  name  = "swarm_node-${count.index + 1}"
  image = "${data.scaleway_image.docker.id}"
  type  = "${var.scw_type_node}"
  count = "${var.swarm_nodes}"
  dynamic_ip_required = true

  volume {
    size_in_gb = 50
    type = "l_ssd"
  }

  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook -i '${self.public_ip},' --private-key ${var.scw_ssh_key} '../../ansible/swarm_node.ansible.yaml' -T 300"
  }
}