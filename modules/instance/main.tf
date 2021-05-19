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


#create a service role for EC2
resource "aws_iam_role" "instance_role" {
  name = "instance_role_terraform"
  description = "Instance Role by Terraform"
  assume_role_policy = file("assume-role-policy.json")
}

#create a policy for EC2
resource "aws_iam_policy" "instance_policy" {
  name = "instance_policy_terraform"
  description = "Instance Policy by Terraform"
  policy = file("policy.json")
}

resource "aws_iam_role_policy_attachment" "instance_attach" {
  role       = aws_iam_role.instance_role.name
  policy_arn = aws_iam_policy.instance_policy.arn
}