provider aws {
    profile = "mihai-admin"
    region = var.region
}

resource "aws_instance" "codedeploy_instance" {
  ami                   = "ami-0aaaf7510b24fd3d6"
  instance_type         = var.instance_type
  key_name              = "mihai-aws"                       
  #iam_instance_profile  = aws_iam_instance_profile.instance.name

  tags = {
    Name = "CodeDeploy_Instance"
  }


}