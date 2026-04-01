variable "vpc_id" {}
variable "subnets" {
  type = list(string)
}
variable "env" {}
variable "alb_sg_id" {}