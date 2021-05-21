provider aws {
    profile = var.profile
    region = var.region
}

resource "aws_instance" "codedeploy_instance" {
  ami                   = var.instace_ami
  instance_type         = var.instance_type
  key_name              = var.instance_key                       
  iam_instance_profile  = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name = var.instace_name
  }
}
