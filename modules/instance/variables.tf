variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "profile" {
  description = "AWS profile"
  default     = "mihai-admin"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}


variable "instace_name" {
  description = "AWS instance"
  default     = "CodeDeploy_Instance-Main"
}


variable "instace_ami" {
  description = "AWS AMI"
  default     = "ami-0aaaf7510b24fd3d6"
}

variable "instace_key" {
  description = "AWS key"
  default     = "mihai-aws"
}



// variable instance_profile {
//   description = "CodeDeploy Instance Profile"
//   default = aws_iam_instance_profile.instance.name       # -> resource.aws_iam_instance_profile
// }