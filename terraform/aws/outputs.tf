output "Docker Swarm Manager(s) Public IPs" {
  value = "${join("\n               ", formatlist("%s", split(",", aws_instance.swarm_manager.public_ip)))}"
}
output "1" {
  value = "${join("\n               ", formatlist("%s", data.aws_ami.ubuntu.root_device_name))}"
}
output "2" {
  value = "${join("\n               ", formatlist("%s", data.aws_ami.ubuntu.root_device_type))}"
}
output "3" {
  value = "${join("\n               ", formatlist("%s", data.aws_ami.ubuntu.image_owner_alias))}"
}
//
//output "Docker Swarm Node(s) Public IPs" {
//  value = "${join("\n               ", formatlist("%s", split(",", aws_instance.swarm_node.*.public_ip)))}"
//}