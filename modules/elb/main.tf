resource "aws_lb" "elb" {
  name               = var.elb_name
  load_balancer_type = var.elb_type
  subnets            = var.elb_subnets[aws_subnet.example_subnet.id]
}

resource "aws_lb_target_group" "target_group" {
  name     = var.elb_target_group_name
  port     = var.elb_target_group_port
  protocol = var.elb_target_group_protocol
  vpc_id   = var.elb_target_group_vpc

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

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.elb.arn
  port              = var.elb_listener_port
  protocol          = var.elb_listener_protocol

  default_action {
    type             = var.elb_listener_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}