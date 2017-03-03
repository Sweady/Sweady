resource "aws_security_group" "swarm" {
  name = "swarm"
  description = "Allow all traffic"

  ingress {
    from_port = 5
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Swarm"
  }
}
