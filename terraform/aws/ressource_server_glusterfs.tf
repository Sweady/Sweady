resource "aws_instance" "swarm_glusterfs" {
  instance_type = "${var.aws_type_glusterfs}"
  ami = "${var.aws_ami}"
  count = "${var.swarm_glusterfs}"
  associate_public_ip_address = true
  key_name = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.swarm.name}"]

  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook -i '${self.public_ip},' --private-key ${var.aws_ssh_key} '../../ansible/swarm_glusterfs.ansible.yaml' -T 300 --user=ubuntu"
  }

  tags {
    Name = "swarm_glusterfs-${count.index + 1}"
  }
}
