resource "aws_instance" "swarm_node" {
  instance_type = "${var.aws_type_node}"
  ami = "${var.aws_ami}"
  key_name = "${var.aws_key_name}"
  count = "${var.swarm_nodes}"
  associate_public_ip_address = true
  security_groups = ["${aws_security_group.swarm.name}"]

  connection {
    user     = "${var.aws_ami_user}"
    private_key = "${file("${var.aws_ssh_key}")}"
    agent = false
  }

  provisioner "file" {
    source = "swarm.token"
    destination = "/tmp/node.token"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt-get install apt-transport-https ca-certificates -y",
      "sudo apt install curl -y",
      "sudo curl -fsSL https://get.docker.com/ | sudo sh",
      "sudo docker swarm join --token $(cat /tmp/node.token) ${aws_instance.swarm_manager.private_ip}:2377"
    ]
  }

  tags {
    Name = "swarm_node-${count.index + 1}"
  }
}
