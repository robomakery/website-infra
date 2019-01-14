terraform {
  backend "s3" {
    bucket  = "robomakery-prod-tf-state-us-west-2"
    key     = "prod1/terraform.tfstate"
    region  = "us-west-2"
  }
}

provider "aws" {
  region  = "us-west-2"
  version = "~> 0.1"
}

module "website" {
  source  = "ordinaryexperts/static-website-with-cicd/aws"
  version = "0.2.0"

  code_build_docker_image_identifier = "aws/codebuild/ruby:2.5.3"
  cert_arn = "arn:aws:acm:us-east-1:948047677080:certificate/94d617a3-0b2b-4c9b-950d-0ccf7f163e38"
  code_commit_repo_branch = "master"
  code_commit_repo_name = "website"
  env = "prod1"
  url = "robomakery.com"
}
