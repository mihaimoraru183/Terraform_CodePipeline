


resource "aws_iam_role" "codebuild_role" {
  name = "code_build_terraform"
  assume_role_policy = file("${path.module}/iam/codebuild-role.json")
}                      


resource "aws_iam_role_policy" "codebuild_policy" {
  role = aws_iam_role.codebuild_role.name
  policy = file("${path.module}/iam/codebuild-policy.json")
}



resource "aws_codebuild_project" "codebuild_app" {
  name          = "codebuild_app_terraform"
  description   = "codebuild_app_terraform"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket

  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    // environment_variable {
    //   name  = "SOME_KEY1"
    //   value = "SOME_VALUE1"
    // }

    // environment_variable {
    //   name  = "SOME_KEY2"
    //   value = "SOME_VALUE2"
    //   type  = "PARAMETER_STORE"
    // }
  }

 


  source {
    type            = "GITHUB"
    location        = "https://github.com/mihaimoraru183/my_php"
    git_clone_depth = 1
  }


  tags = {
    Environment = "Test"
  }
}

