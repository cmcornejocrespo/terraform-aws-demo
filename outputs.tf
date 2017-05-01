output "elastic ip" {
  value = "${aws_eip.default.public_ip}"
}