resource "aws_launch_template" "shadow-asg-lt01" {
  name                   = "shadow-asg-lt01"
  description            = "Launch template for ASG"
  image_id               = "ami-00f943f626f580b28"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.asg-sg01-tg01.id]
  user_data              = filebase64("./startup.sh")

  tags = {
    Resource_type = "Instance"
    Name          = "shadow-asg-lt01"
    Service       = "Auto Sclaing"
    Env           = "Test"
  }

  lifecycle {
    create_before_destroy = true
  }
}
