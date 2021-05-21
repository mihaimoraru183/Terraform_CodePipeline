# Create roles and policies for CodePipeline

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline_role_terraform"
  assume_role_policy = file("${path.module}/iam/codepipeline-role.json")
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id
  policy = file("${path.module}/iam/codepiline-policy.json")
}


resource "aws_codestarconnections_connection" "codepipeline_conn" {
  name          = "codepipeline_conn_github"
  provider_type = "GitHub"
}


resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-bucket-terraform"
  acl    = "private"
}



resource "aws_codepipeline" "codepipeline" {
  name     = "pipeline_terraform"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }
//     encryption_key {
//       id   = data.aws_kms_alias.s3kmskey.arn
//       type = "KMS"
//     }
//   }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.codepipeline_conn.arn
        FullRepositoryId = "git@github.com:mihaimoraru183/test_web_page.git"
        BranchName       = "master"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "test"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        
        ApplicationName = "demo_app"
        DeploymentGroupName = "demo_app"
        // ActionMode     = "REPLACE_ON_FAILURE"
        // Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        // OutputFileName = "CreateStackOutput.json"
        // StackName      = "MyStack"
        // TemplatePath   = "build_output::sam-templated.yaml"
      }
    }
  }
}



// data "aws_kms_alias" "s3kmskey" {
//   name = "alias/myKmsKey"
// }