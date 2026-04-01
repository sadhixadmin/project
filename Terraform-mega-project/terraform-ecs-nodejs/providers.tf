terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "nova-tf-state907081"
    key          = "ecs-nodejs/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = "true"
  }
}

provider "aws" {
  region = var.region
}