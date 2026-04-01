output "alb_url" {
  value = module.alb.alb_dns
}

# output "app_url" {
#   value = "http://app.${var.domain}"
# }