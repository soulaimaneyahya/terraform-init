provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {
  type = string
  sensitive = true
}

variable "aws_secret_key" {
  type = string
  sensitive = true
}

# Resources
resource "aws_instance" "aws_servers" {
  ami = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
}

# Output
output "aws_ip" {
  value = [for server in aws_instance.aws_servers : server]
}
