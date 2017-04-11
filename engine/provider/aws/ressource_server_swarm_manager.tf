resource "aws_instance" "swarm_manager" {
  instance_type               = "${var.aws_type_node}"
  ami                         = "${var.aws_ami}"
  count                       = "${var.swarm_manager}"
  associate_public_ip_address = true
  key_name                    = "${var.aws_key_name}"

  subnet_id = "${aws_subnet.eu-west-1a.id}"

  tags {
    Name = "swarm_manager-${count.index + 1}"
  }
}
