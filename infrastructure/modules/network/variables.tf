# Project and environment
variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

# Optional: list of subnet CIDRs
variable "subnets" {
  type = list(object({
    name       = string
    cidr_block = string
  }))
  default = [
    {
      name       = "public-subnet"
      cidr_block = "10.0.1.0/24"
    },
    {
      name       = "private-subnet"
      cidr_block = "10.0.2.0/24"
    }
  ]
}

# Optional: enable firewall rules
variable "enable_firewall" {
  type    = bool
  default = true
}