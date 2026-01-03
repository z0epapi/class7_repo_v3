# resource "aws_autoscaling_group" "office-hours-asg01" {
#   name_prefix           = "office-hours-asg01"
#   min_size              = 3
#   max_size              = 9
#   desired_capacity      = 6
#   vpc_zone_identifier   = [
#     aws_subnet.private-eu-west-1a.id,
#     aws_subnet.private-eu-west-1b.id,
#     aws_subnet.private-eu-west-1c.id
#   ]
#   health_check_type          = "ELB"
#   health_check_grace_period  = 300
#   force_delete               = true
#   target_group_arns          = [aws_lb_target_group.office-hours-tg01.arn]

#   launch_template {
#     id      = aws_launch_template.app1_LT.id
#     version = "$Latest"
#   }

#   enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]

#   # Instance protection for launching
#   initial_lifecycle_hook {
#     name                  = "instance-protection-launch"
#     lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
#     default_result        = "CONTINUE"
#     heartbeat_timeout     = 60
#     notification_metadata = "{\"key\":\"value\"}"
#   }

#   # Instance protection for terminating
#   initial_lifecycle_hook {
#     name                  = "scale-in-protection"
#     lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
#     default_result        = "CONTINUE"
#     heartbeat_timeout     = 300
#   }

#   tag {
#     key                 = "Name"
#     value               = "office hours ASG instance"
#     propagate_at_launch = true
#   }

#   tag {
#     key                 = "Purpose"
#     value               = "Demo"
#     propagate_at_launch = true
#   }
# }


# # Auto Scaling Policy
# resource "aws_autoscaling_policy" "office-hours-scaling-policy" {
#   name                   = "app1-cpu-target"
#   autoscaling_group_name = aws_autoscaling_group.office-hours-asg01.name

#   policy_type = "TargetTrackingScaling"
#   estimated_instance_warmup = 120

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = 75.0
#   }
# }

# # Enabling instance scale-in protection
resource "aws_autoscaling_attachment" "office-hours-asg01-attachment" {
  autoscaling_group_name = aws_autoscaling_group.office-hours-asg01.name
  lb_target_group_arn   = aws_lb_target_group.office-hours-tg01.arn
}

resource "aws_autoscaling_group" "office-hours-asg01" {
  availability_zones = ["eu-west-2a"]
  desired_capacity   = 6
  max_size           = 9
  min_size           = 3

  launch_template {
    id      = aws_launch_template.office-hours-launch-template.id
    version = "$Latest"
  }
}