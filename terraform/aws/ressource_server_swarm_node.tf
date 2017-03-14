resource "aws_instance" "swarm_node" {
  instance_type = "${var.aws_type_node}"
  ami = "${var.aws_ami}"
  count = "${var.swarm_nodes}"
  associate_public_ip_address = true
  key_name = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.swarm.name}"]

  provisioner "local-exec" {
    command = "sleep 60 && ansible-playbook -i '${self.public_ip},' --private-key ${var.aws_ssh_key} '../../ansible/swarm_node.ansible.yaml' -T 300 --user=ubuntu"
  }

  tags {
    Name = "swarm_node-${count.index + 1}"
  }
}
