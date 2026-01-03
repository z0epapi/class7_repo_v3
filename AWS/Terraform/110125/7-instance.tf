# data "aws_ami" "amzn-linux-2023-ami" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023.*-x86_64"]
#   }
# }

# resource "aws_instance" "crossroads-server" {
#   ami           = data.aws_ami.amzn-linux-2023-ami.id
#   instance_type = "t3.micro"
#   subnet_id     = aws_subnet.public-sa-east-1a.id
#   vpc_security_group_ids = [aws_security_group.crossroads-sg.id]
#   user_data = file("./startup.sh")

#   tags = {
#     Name = "test-server"
#   }
# }

resource "aws_instance" "ogoun-ec2" {
  ami                         = "ami-0d24c0a5692fe1184" # sa-east-1
  instance_type               = "t3.small"
  security_groups             = [aws_security_group.gad-sg.id]
#   vpc_security_group_ids      = [aws_security_group.gad-sg.id]
  subnet_id                   = aws_subnet.public-sa-east-1a.id
  associate_public_ip_address = true # Class was unsure if this is needed, if subnethas a
  user_data                   = file("./startup.sh")

  tags = {
    Name = "test-server"
  }
}