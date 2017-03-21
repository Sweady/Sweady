resource "aws_instance" "swarm_worker" {
  instance_type               = "${var.aws_type_node}"
  ami                         = "${var.aws_ami}"
  count                       = "${var.swarm_nodes}"
  associate_public_ip_address = true
  key_name                    = "${var.aws_key_name}"
//  security_groups             = ["${aws_security_group.swarm.name}"]
  subnet_id                   = "${aws_subnet.eu-west-1a.id}"

  tags {
    Name = "swarm_node-${count.index + 1}"
  }
}
