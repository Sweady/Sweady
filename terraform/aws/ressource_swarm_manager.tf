resource "aws_instance" "swarm_manager" {
  instance_type = "${var.aws_type_node}"
  ami = "${var.aws_ami}"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = true
  security_groups = ["${aws_security_group.swarm.name}"]

  connection {
    user     = "${var.aws_ami_user}"
    private_key = "${file("${var.aws_ssh_key}")}"
    agent = false
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt upgrade -o Dpkg::Options::='--force-confold' --force-yes -y",
      "sudo apt install curl -y",
      "sudo curl -fsSL https://get.docker.com/ | sudo sh",
      "sudo docker swarm  init",
      "sudo docker swarm join-token -q worker >> /tmp/swarm.token"
    ]
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.aws_ssh_key} admin@${aws_instance.swarm_manager.public_ip}:/tmp/swarm.token ."
  }

  tags {
    Name = "swarm_manager"
  }
}
