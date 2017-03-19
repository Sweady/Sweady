resource "aws_instance" "swarm_manager" {
  instance_type               = "${var.aws_type_manager}"
  ami                         = "${var.aws_ami}"
  associate_public_ip_address = true
  key_name                    = "${var.aws_key_name}"
  security_groups             = ["${aws_security_group.swarm.name}"]

  tags {
    Name = "swarm_manager"
  }
}
