output "instance_role_named" {
  value = module.ec2_instances.instance_role_name
}

output "instance_arn" {
  value = module.ec2_instances.instance_policy_arn
}

// output "instance_policy_arn" {
//   value = module.ec2_instances.aws_iam_policy.instance_policy.arn
// }
