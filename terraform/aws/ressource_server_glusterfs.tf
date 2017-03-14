resource "aws_instance" "swarm_glusterfs" {
  instance_type = "${var.aws_type_glusterfs}"
  ami = "${var.aws_ami}"
  count = "${var.swarm_glusterfs}"
  associate_public_ip_address = true
  key_name = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.swarm.name}"]

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 50
    volume_type = "gp2"
    delete_on_termination = true
  }

  provisioner "local-exec" {
    command = "sleep 60 && ansible-playbook -i '${self.public_ip},' --private-key ${var.aws_ssh_key} '../../ansible/swarm_glusterfs.ansible.yaml' -T 300 -e 'disk=xvdb' --user=ubuntu"
  }

  tags {
    Name = "swarm_glusterfs-${count.index + 1}"
  }
}