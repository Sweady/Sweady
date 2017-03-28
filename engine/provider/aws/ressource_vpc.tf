resource "aws_vpc" "sweady" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "Sweady"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.sweady.id}"

  tags {
    Name = "Sweady-gw"
  }
}

resource "aws_subnet" "eu-west-1a" {
  vpc_id                  = "${aws_vpc.sweady.id}"
  availability_zone       = "eu-west-1a"
  cidr_block              = "${cidrsubnet(aws_vpc.sweady.cidr_block, 4, 1)}"
  map_public_ip_on_launch = true

  tags {
    Name             = "Sweady-infra-subnet"
    AvailabilityZone = "eu-west-1a"
  }
}

resource "aws_default_route_table" "r" {
  default_route_table_id = "${aws_vpc.sweady.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "default table"
  }
}
