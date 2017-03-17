provider "scaleway" {
  token = "${var.scw_token}"
  organization = "${var.scw_organization}"
  region = "${var.scw_region}"
}