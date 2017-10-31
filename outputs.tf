# Return availability zone list
output "availability_zones" {
  value = [
    "${data.aws_availability_zones.all_zones.names}"]
}

# Return LB dns
output "elb_dns" {
  value = "${aws_elb.enmilocalfunciona_elb.dns_name}"
}