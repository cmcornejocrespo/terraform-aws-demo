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
  default = "enmilocalfunciona-terraform-key"
}