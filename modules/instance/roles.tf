
#create a service role for EC2
resource "aws_iam_role" "instance_role" {
  name = "instance_role_terraform"
  description = "Instance Role by Terraform"
  assume_role_policy = file("${path.module}/iam/assume-role-policy.json")
}

#create a policy for EC2
resource "aws_iam_policy" "instance_policy" {
  name = "instance_policy_terraform"
  description = "Instance Policy by Terraform"
  policy = file("${path.module}/iam/policy.json")
}

resource "aws_iam_role_policy_attachment" "instance_attach" {
 # name       = "instance_attach_terraform"
  role       = aws_iam_role.instance_role.name
  policy_arn = aws_iam_policy.instance_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.instance_role.name
}