variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-2"
}

variable "aws_amis" {
  description = "Ubuntu 16.04 AMIS"
  default = {
    eu-west-1 = "ami-a8d2d7ce" // EU (Ireland)
    eu-west-2 = "ami-f1d7c395" // EU (London)
    eu-central-1 = "ami-060cde69" //EU (Frankfurt)
  }
}
variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = {
    eu-west-1 = "enmilocalfunciona-terraform-key-eu-west-1" // EU (Ireland)
    eu-west-2 = "enmilocalfunciona-terraform-key-eu-west-2" // EU (London)
    eu-central-1 = "enmilocalfunciona-terraform-key-eu-central-1" //EU (Frankfurt)
  }
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "8"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "2"
}