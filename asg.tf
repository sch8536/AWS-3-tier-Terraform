resource "aws_ami_from_instance" "webserver_ami" {
  source_instance_id = aws_instance.WebServer.id
  name        = "webserver-ami"
}

resource "aws_launch_template" "promet_temp" {
  name_prefix = "PROmet-Temp"
  image_id    = aws_ami_from_instance.webserver_ami.id

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "PROmet-Temp"
    }
  }

  monitoring {
    enabled = true
  }

  instance_type = "t2.micro"
  key_name      = aws_key_pair.webserver_keypair.key_name

  vpc_security_group_ids = [aws_security_group.WebServer-sg.id]

  placement {
    availability_zone = "ap-northeast-2c"
  }
}

resource "aws_autoscaling_group" "asg_promet" {
  name_prefix                 = "ASG-PROmet"
  max_size                    = 2
  min_size                    = 1
  desired_capacity            = 1
  vpc_zone_identifier         = [aws_subnet.application-subnet-1.id, aws_subnet.application-subnet-2.id]
  launch_template {
    id      = aws_launch_template.promet_temp.id
    version = "$Latest"
  }
  target_group_arns           = [aws_lb_target_group.alb-g.arn]
  health_check_type           = "ELB"

  tag {
    key                 = "Name"
    value               = "ASG-PROmet"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "asg-policy" {
  name                   = "ASG-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg_promet.name

  target_tracking_configuration {
    target_value = 50
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}


