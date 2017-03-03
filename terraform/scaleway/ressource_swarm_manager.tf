resource "scaleway_server" "swarm_manager" {
  name  = "swarm_manager"
  image = "${data.scaleway_image.docker.id}"
  type  = "${var.scw_type_manager}"
  dynamic_ip_required = true

  volume {
    size_in_gb = 50
    type = "l_ssd"
  }

  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook -i '${self.public_ip},' --private-key ${var.scw_ssh_key}  '../../ansible/swarm_manager.ansible.yaml' -T 300"
  }
}