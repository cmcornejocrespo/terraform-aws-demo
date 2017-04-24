provider "aws" {
  region = "${var.aws_region}"
}
resource "aws_instance" "enmilocalfunciona" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "t2.micro"
  tags {
    name = "tag-enmilocalfunciona"
    Name = "enmilocalfunciona"
  }
}
