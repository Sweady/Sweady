resource "aws_instance" "swarm_worker" {
  instance_type               = "${var.aws_type_node}"
  ami                         = "${var.aws_ami}"
  count                       = "${var.swarm_nodes}"
  associate_public_ip_address = true
  key_name                    = "${var.aws_key_name}"
  security_groups             = ["${aws_security_group.swarm.name}"]

  tags {
    Name = "swarm_node-${count.index + 1}"
  }
}
