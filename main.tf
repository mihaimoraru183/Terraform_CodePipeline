terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
  profile = var.profile
}


module "ec2_instances" {
  source  = "./modules/instance"
  instance_key = "mihai-aws"
  instance_type = "t2.micro"
  #version = "2.12.0"
}

//   name           = var.instance_name
//   instance_count = 1
// //   ami                    = var.instance_ami
// //   instance_type          = var.instance_type
//   tags = {
//     Terraform   = "true"
//     Environment = "Test"
//   }


// module "code_deploy" {
//   source  = "./modules/codepipeline/"
// }

module "codepipeline" {
  source  = "./modules/codepipeline/"
}