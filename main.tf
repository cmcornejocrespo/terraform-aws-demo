# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Our default security group to access
# the instances over HTTP
resource "aws_security_group" "enmilocalfunciona_sg" {

  name = "enmilocalfunciona-security-group"
  description = "Security Group used for enmilocalfunciona"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

# Return availability zones list
data "aws_availability_zones" "all_zones" {}

#Create LB for availability_zones
resource "aws_elb" "enmilocalfunciona_elb" {

  name = "enmilocalfunciona-elb"
  availability_zones = ["${data.aws_availability_zones.all_zones.names}"]
  security_groups = ["${aws_security_group.enmilocalfunciona_sg.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }
}
# Create configuration launcher
resource "aws_launch_configuration" "enmilocalfunciona_lc" {

  name = "enmilocalfunciona-lc"
  image_id = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.enmilocalfunciona_sg.id}"]
  # What ro tun inside
  user_data = "${file("provision.sh")}"
  # SSH key
  key_name = "${lookup(var.key_name, var.aws_region)}"
}

# Configure asg
resource "aws_autoscaling_group" "enmilocalfunciona_asg" {

  name = "enmilocalfunciona-asg"
  availability_zones = ["${data.aws_availability_zones.all_zones.names}"]
  max_size = "${var.asg_max}"
  min_size = "${var.asg_min}"
  desired_capacity = "${var.asg_desired}"
  force_delete = true
  # What to do every time it scales
  launch_configuration = "${aws_launch_configuration.enmilocalfunciona_lc.name}"
  # Place new instances inside this LB
  load_balancers = ["${aws_elb.enmilocalfunciona_elb.name}"]

  tag {
    key = "Name"
    value = "enmilocalfunciona-asg"
    propagate_at_launch = "true"
  }
}