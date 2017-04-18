resource "aws_key_pair" "sweady" {
  key_name_prefix   = "sweady_"
  public_key = "${file("../../data/sweady.pub")}"
}