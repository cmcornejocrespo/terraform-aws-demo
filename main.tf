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

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.demo.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo.id}"
}

# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name        = "security_group_elb"
  description = "SG used to link to LB"
  vpc_id      = "${aws_vpc.demo.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "security_group_default"
  description = "Default SSH SG linked to subnet access"
  vpc_id      = "${aws_vpc.demo.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_elb" "web-access" {
  name = "aws-elb-web-access"
  subnets         = ["${aws_subnet.demo.id}"]
  security_groups = ["${aws_security_group.elb.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}