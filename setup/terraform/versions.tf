provider "aws" {
  region = "us-east-1"
  profile = "uda2"
  shared_credentials_files = ["~/.aws/credentials"]
}

terraform {
  required_version = "1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}
