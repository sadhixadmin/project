module "vpc" {
  source = "../modules/vpc"

  cidr           = var.cidr
  public_subnets = var.public_subnets
  azs            = var.azs
  env            = var.env

}

module "alb" {
  source = "../modules/alb"

  vpc_id    = module.vpc.vpc_id
  subnets   = module.vpc.public_subnet_ids
  alb_sg_id = module.vpc.alb_sg_id
  env       = var.env
}

# module "iam" {
#   source = "../modules/iam"

#   env = var.env
# }

# ---------------- ECS ----------------

resource "aws_ecs_cluster" "this" {
  name = local.name
}

resource "aws_ecs_task_definition" "app" {
  family                   = local.name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512

  # execution_role_arn = module.iam.execution_role_arn


  container_definitions = jsonencode([
    {
      name  = "nginx"
      image = var.image
      portMappings = [{
        containerPort = 80
      }]
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = local.name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = module.vpc.public_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = module.alb.target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }
}

# ---------------- Route53 ----------------
#if you want wright zone code


# resource "aws_route53_record" "app" {
#   zone_id = var.zone_id
#   name    = "app.${var.domain}"
#   type    = "A"

#   alias {
#     name                   = module.alb.alb_dns
#     zone_id                = module.alb.alb_zone_id
#     evaluate_target_health = true
#   }
# }


