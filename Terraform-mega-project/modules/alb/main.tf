resource "aws_lb" "this" {
  name               = "${var.env}-alb"
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [var.alb_sg_id] 
}

resource "aws_lb_target_group" "this" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
  path                = "/"
  port                = "traffic-port"
  protocol            = "HTTP"
  matcher             = "200"
  interval            = 30
  timeout             = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}


