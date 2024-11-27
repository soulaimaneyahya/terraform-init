provider "linode" {
  token = var.linode_token
}

variable "linode_token" {
  type = string
  sensitive = true
}

variable "instance_type" {
  default = "g6-nanode-1"
  description = "1GB Nanode instance"
}

variable "region" {
  default = "us-east"
  description = "US east"
}

variable "image" {
  default = "linode/ubuntu23.10"
  description = "linode/ubuntu23.10"
}

variable "instancesCount" {
  type = number
  default = 1
}

# Resources
resource "linode_instance" "linode_servers" {
  count = var.instancesCount

  label      = "ubuntu-us-east-${count.index +1}"
  region     = var.region
  type       = var.instance_type
  image      = var.image
  root_pass  = random_password.instance_root_pass[count.index].result

  tags = ["terraform", "linode"]
}

resource "random_password" "instance_root_pass" {
  count   = var.instancesCount
  length  = 16
  special = true
}

# Output
output "linode_ip" {
  value = [for server in linode_instance.linode_servers : server.ip_address]
}

output "linode_instance_root_password" {
  value     = [for pass in random_password.instance_root_pass : pass.result]
  sensitive = true
}

output "linode_instance_labels" {
  value = [for server in linode_instance.linode_servers : server.label]
}
