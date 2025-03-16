// Provider Configuration
provider "linode" {
  token = var.linode_token // Linode API token
}

// vars
variable "linode_token" {
  type      = string
  sensitive = true
}

variable "instance_type" {
  default     = "g6-nanode-1" // Default instance type (1GB Nanode)
  description = "1GB Nanode instance"
}

variable "region" {
  default     = "us-east" // Default region
  description = "US east"
}

variable "image" {
  default     = "linode/ubuntu23.10" // Ubuntu 23.10 image
  description = "linode/ubuntu23.10"
}

variable "instancesCount" {
  type    = number // Number of instances to create
  default = 1 // Default instance count is 1
}

// Resources
resource "linode_instance" "linode_servers" {
  count      = var.instancesCount // Create multiple instances based on count

  label      = "ubuntu-us-east-${count.index + 1}" // Unique label for each instance
  region     = var.region // Set the region for the instance
  type       = var.instance_type // Instance type for resources
  image      = var.image // OS image to install
  root_pass  = random_password.instance_root_pass[count.index].result // Root password assignment

  tags = ["terraform", "linode"] // Tags
}

// Both linode_instance and random_password use the same count to ensure each instance gets a unique password
resource "random_password" "instance_root_pass" {
  count   = var.instancesCount // Same count as instances
  length  = 16
  special = true // Include special chars
}

// Output
output "linode_ip" {
  value = [for server in linode_instance.linode_servers : server.ip_address] // List IP addresses of created instances
}

output "linode_instance_root_password" {
  value     = [for pass in random_password.instance_root_pass : pass.result] // List generated root passwords
  sensitive = true // Marked sensitive to avoid accidental exposure
}

output "linode_instance_labels" {
  value = [for server in linode_instance.linode_servers : server.label] // Display labels for identification
}
