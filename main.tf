provider "aws" {
  region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "vpc-enmilocalfunciona"
  }
}

# Create a subnet to launch our instances into
resource "aws_subnet" "demo" {
  vpc_id                  = "${aws_vpc.demo.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags {
    Name = "subnet-enmilocalfunciona"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "demo" {
  vpc_id = "${aws_vpc.demo.id}"
  tags {
    Name = "internet_gateway-enmilocalfunciona"
  }
}
