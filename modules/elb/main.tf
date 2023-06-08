resource "aws_lb" "elb" {
  name               = var.elb_name
  load_balancer_type = var.elb_type
  subnets            = var.elb_subnets
}

resource "aws_lb_target_group" "target_group" {
  name        = var.elb_target_group_name
  port        = var.elb_target_group_port
  protocol    = var.elb_target_group_protocol
  vpc_id      = var.elb_target_group_vpc
  target_type = "ip"

  health_check {
    interval            = var.elb_group_target_heatlh_interval
    path                = var.elb_group_target_heatlh_path
    port                = var.elb_group_target_heatlh_port
    protocol            = var.elb_group_target_heatlh_protocol
    timeout             = var.elb_group_target_heatlh_timeout
    healthy_threshold   = var.elb_group_target_heatlh_threshold
    unhealthy_threshold = var.elb_group_target_unhealthy_threshold
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.elb_target_group_attachment_id
  port             = var.elb_target_group_attachment_port
}

resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.elb.arn
  port              = var.elb_listener_port_http
  protocol          = var.elb_listener_protocol_http

  default_action {
    type             = var.elb_listener_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
