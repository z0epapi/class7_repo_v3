resource "aws_autoscaling_group" "shadow-asg" {
  name                      = "shadow-asg"
  max_size                  = 9
  min_size                  = 3
  desired_capacity          = 6
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true


  vpc_zone_identifier = [aws_subnet.private-sa-east-1a.id, aws_subnet.private-sa-east-1b.id, aws_subnet.private-sa-east-1c.id]

  launch_template {
    id      = aws_launch_template.shadow-asg-lt01.id
    version = "$Latest"
  }


  availability_zone_distribution {
    capacity_distribution_strategy = "balanced-best-effort"
  }

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

  tag {
    key                 = "Name"
    value               = "shadow-asg"
    propagate_at_launch = true
  } # Tagging convention for ASG???

  tag {
    key                 = "Env"
    value               = "Test"
    propagate_at_launch = true
  } # Tagging convention for ASG???

  tag {
    key                 = "Service"
    value               = "Auto Scaling"
    propagate_at_launch = true
  } # Tagging convention for ASG???           

  tag {
    key                 = "Resource_type"
    value               = "Auto Scaling Group"
    propagate_at_launch = true
  } # Tagging convention for ASG???

}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "shadow-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.shadow-asg.id
  lb_target_group_arn    = aws_lb_target_group.shadow-tg.arn
}

# Create SNS Topic for ASG
resource "aws_autoscaling_notification" "shadow-asg-notifications" {
  group_names = [
    aws_autoscaling_group.shadow-asg.name,
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.auto-scaling-alerts.arn
}

resource "aws_sns_topic" "auto-scaling-alerts" {
  name = "auto-scaling-alerts"

  # arn is an exported attribute
}

# Defines Target Tracking Scaling Policy
resource "aws_autoscaling_policy" "shadow-asg" {
  autoscaling_group_name = aws_autoscaling_group.shadow-asg.name
  name                   = "shadow-asg"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50
  }
}