variable "ami_name" {
  type    = string
  default = "Image for CodePipeline"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

source "amazon-ebs" "codepipeline" {
  ami_name      = var.ami_name
  instance_type = "t2.micro"
  region        = var.region
  profile = "mihai-admin"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
   
}

build {
  sources = [
    "source.amazon-ebs.codepipeline"
  ]
}