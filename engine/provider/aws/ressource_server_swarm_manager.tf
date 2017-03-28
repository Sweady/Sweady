resource "aws_instance" "swarm_manager" {
  instance_type               = "${var.aws_type_manager}"
  ami                         = "${var.aws_ami}"
  associate_public_ip_address = true
  key_name                    = "${var.aws_key_name}"

  subnet_id = "${aws_subnet.eu-west-1a.id}"

  tags {
    Name = "swarm_manager"
  }
}
