data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "office-hours-instance" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-eu-west-2a.id
  vpc_security_group_ids = [aws_security_group.office-hours-sg01.id]
  user_data = file("/.startup.sh")

  tags = {
    Name = "office-hours-instance"
  }
}
##################################################################################

resource "aws_launch_template" "office-hours-launch-template" {
  name_prefix   = "office-hours-lt-intance"
  image_id      = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
}

