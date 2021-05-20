variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

// variable instance_profile {
//   description = "CodeDeploy Instance Profile"
//   default = aws_iam_instance_profile.instance.name       # -> resource.aws_iam_instance_profile
// }