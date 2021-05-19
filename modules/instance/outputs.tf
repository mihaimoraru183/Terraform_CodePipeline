output "instance_role_name" {
  value = aws_iam_role.instance_role.name
}


output "instance_policy_arn" {
  value = aws_iam_policy.instance_policy.arn
}
