# khai báo provider, xác thực
provider "aws" {
  // access_key = "***"
  // secret_key = "***"
  region = "ap-southeast-1" # Singapore region
}

# taọ alb load balancer

resource "aws_lb" "web" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_lb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

# tạo lb target group 

resource "aws_lb_target_group" "web" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = 80
    healthy_threshold   = 2
    interval            = 5
    unhealthy_threshold = 2
    timeout             = 3
  }
}

# thêm ec2 instance vào web target group

resource "aws_lb_target_group_attachment" "web_ec2" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.web.id
  port             = 80
}

# tạo alb listener

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}


# tạo web-alb security group allow http

resource "aws_security_group" "web_lb" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from All"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# in ra dns name của load balancer
output "aws_alb_web_dns_name" {
  value = aws_lb.web.dns_name
}
