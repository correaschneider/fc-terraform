terraform {
  required_version = ">= 1.7.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "fc"
}