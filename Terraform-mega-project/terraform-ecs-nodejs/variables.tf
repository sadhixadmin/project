variable "region" {}
variable "env" {}
variable "project_name" {}

variable "cidr" {}

variable "public_subnets" {
  type = list(string)
}

variable "image" {}

# variable "domain" {}
# variable "zone_id" {}

variable "azs" {
  type = list(string)
}