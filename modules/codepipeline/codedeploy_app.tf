# Create roles and policies for CodeDeploy

// Create a service role for CodeDeploy
resource "aws_iam_role" "deploy_role" {
  name = "codedeploy_role"
  assume_role_policy = file("${path.module}/iam/role.json")
}


#create a policy for CodeDeploy
resource "aws_iam_policy" "deploy_policy" {
  name = "deploy_policy_terraform"
  description = "CodeDeploy Policy by Terraform"
  policy = file("${path.module}/iam/policy.json")
}


resource "aws_iam_role_policy_attachment" "codedeploy_attach" {
  role       = aws_iam_role.deploy_role.name
  policy_arn = aws_iam_policy.deploy_policy.arn
}






resource "aws_codedeploy_app" "demo_app" {
  name = "demo_app"
}



resource "aws_codedeploy_deployment_group" "demo_app" {
  app_name              = aws_codedeploy_app.demo_app.name
  deployment_group_name = "MyDemoDeploymentGroup"
  service_role_arn      = aws_iam_role.deploy_role.arn

  deployment_config_name = "CodeDeployDefault.OneAtATime"


    ec2_tag_filter {
        key   = "Name"
        type  = "KEY_AND_VALUE" 
        value = "CodeDeploy_Instance-Main"
    }


// Later. It's about notifications
//   trigger_configuration {
//     trigger_events     = ["DeploymentFailure"]
//     trigger_name       = "example-trigger"
//     trigger_target_arn = aws_sns_topic.example.arn
//   }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = false
  }
}