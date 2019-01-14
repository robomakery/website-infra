terraform {
  backend "s3" {
    bucket  = "robomakery-prod-tf-state-us-west-2"
    key     = "dev1/terraform.tfstate"
    region  = "us-west-2"
  }
}

provider "aws" {
  region  = "us-west-2"
  version = "~> 0.1"
}

module "static-website-with-cicd" {
  source  = "ordinaryexperts/static-website-with-cicd/aws"
  version = "0.2.0"

  code_build_docker_image_identifier = "aws/codebuild/ruby:2.5.3"
  cert_arn = "arn:aws:acm:us-east-1:948047677080:certificate/40095007-7ddb-452c-9441-2431e50c285d"
  code_commit_repo_branch = "develop"
  code_commit_repo_name = "website"
  env = "dev1"
  url = "dev.robomakery.com"
}
