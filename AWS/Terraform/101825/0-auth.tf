terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.17.0"
    }
  }
}

provider "aws" {
  # Configuration options

  # default region
  region = "us-east-1"

  # auth profile
  profile = "default"

  default_tags {
    tags = {
      Enivronment = "Lab"
      Managedby   = "Terraform"
    }
  }
}