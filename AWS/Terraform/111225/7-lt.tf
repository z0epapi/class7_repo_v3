
# AMI Data block to make code more resuable instead of being hard-coded
data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# Configure launch template for Auto Scaling Group
resource "aws_launch_template" "shadow-asg-lt01" {
  name                   = "shadow-asg-lt01"
  description            = "Launch template for ASG"
  image_id               = data.aws_ami.amzn-linux-2023-ami.id # Used to reference AMI data block
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.asg-tg-sg01.id] # Make sure to use Target Group Security Group
  user_data              = filebase64("./startup.sh")

  tags = {
    Name          = "shadow-asg-lt01"
    Service       = "Auto Sclaing"
    Env           = "Test"
  }

  lifecycle {
    create_before_destroy = true
  }
}