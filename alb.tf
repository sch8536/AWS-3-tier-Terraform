# Create a new target group
resource "aws_lb_target_group" "alb-g" {
  name_prefix       = "alb-g"
  port              = 80
  protocol          = "HTTP"
  vpc_id            = "${aws_vpc.PROmet-VPC.id}"
  target_type       = "instance"

  stickiness {
    type = "lb_cookie"
    enabled = true
}
}

resource "aws_lb_target_group_attachment" "WebServerAttachment" {
  target_group_arn = aws_lb_target_group.alb-g.arn
  target_id        = aws_instance.WebServer.id
  port             = 80
}

# Create a new application load balancer
resource "aws_lb" "ALB-Web" {
  name               = "ALB-Web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB-sg.id]
  subnets            = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id
  ]
}

resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.ALB-Web.arn
  port              = "80"
  protocol          = "HTTP"
default_action {
  type             = "forward"
  target_group_arn = aws_lb_target_group.alb-g.arn
}
}



