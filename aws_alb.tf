#####################################
# ALB Settings
#####################################
resource "aws_alb" "alb" {
  name = "${var.app_base_name}_ALB"
  subnets = [
    "${aws_subnet.vpc_main-public-subnet1.id}",
    "${aws_subnet.vpc_main-public-subnet2.id}",
  ]
  security_groups = [
    "${aws_security_group.alb_sg.id}",
  ]
}

resource "aws_alb_target_group" "alb_target_group" {
  deregistration_delay = 10
  health_check {
    healthy_threshold   = 2
    interval            = 60
    matcher             = "302"
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 5
  }
  name     = "${var.app_base_name}-target-group"
  port     = 80
  protocol = "HTTP"
  stickiness {
    type = "lb_cookie"
  }

  vpc_id = "${aws_vpc.vpc_main.id}"
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}

