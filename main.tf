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

