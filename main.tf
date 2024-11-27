terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.31.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.78.0"
    }
  }
  required_version = ">= 1.0"
}
