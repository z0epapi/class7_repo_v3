data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-sa-east-1a.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data = file("./startup.sh")

  tags = {
    Name = "test-server"
  }
}