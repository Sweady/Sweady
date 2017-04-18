resource "aws_efs_file_system" "sweady" {
  creation_token = "sweady"

  tags {
    Name = "sweady"
  }
}

resource "aws_efs_mount_target" "sweady" {
  file_system_id = "${aws_efs_file_system.sweady.id}"
  subnet_id      = "${aws_subnet.eu-west-1a.id}"
}

output "mount_target_master_public_subnets_dns_name" {
  value = "${aws_efs_mount_target.sweady.dns_name}"
}
