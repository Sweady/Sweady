resource "aws_instance" "swarm_worker" {
  instance_type               = "${var.aws_type_node}"
  ami                         = "${var.aws_ami}"
  count                       = "${var.swarm_nodes}"
  associate_public_ip_address = true
  key_name                    = "${var.aws_key_name}"

  subnet_id = "${aws_subnet.eu-west-1a.id}"

  tags {
    Name = "swarm_node-${count.index + 1}"
  }

//  connection {
//    type        = "ssh"
//    user        = "ubuntu"
//    private_key = "${file(var.aws_ssh_key)}"
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "sudo docker swarm leave",
//    ]
//    when = "destroy"
//  }
}
