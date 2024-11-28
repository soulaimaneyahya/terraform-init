# Provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Variables
variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

# VPCs
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "dev_vpc"
  }
}

# Subnets
resource "aws_subnet" "main_1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "main-1"
  }
}

resource "aws_subnet" "dev_2" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.1.1.0/24"
  tags = {
    Name = "dev-2"
  }
}

# EC2 Instance in Main VPC
resource "aws_instance" "aws_main_servers" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_1.id

  tags = {
    Name  = "aws_main_instance"
    Owner = "Soulaimane"
  }
}

resource "aws_instance" "aws_dev_servers" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev_2.id

  tags = {
    Name  = "aws_dev_instance"
    Owner = "Soulaimane"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "main_bucket" {
  bucket = "main-bucket-soulaimane"

  tags = {
    Name  = "Main Bucket"
  }
}

resource "aws_s3_bucket" "dev_bucket" {
  bucket = "dev-bucket-soulaimane"

  tags = {
    Name  = "Dev Bucket"
  }
}

# Output
output "aws_main_instance_ip" {
  value = aws_instance.aws_main_servers.public_ip
}

output "aws_dev_instance_ip" {
  value = aws_instance.aws_dev_servers.public_ip
}

# Output for S3 Buckets
output "s3_bucket_names" {
  value = [
    aws_s3_bucket.main_bucket.bucket,
    aws_s3_bucket.dev_bucket.bucket
  ]
}
