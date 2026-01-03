### For Single EC2 ###

resource "aws_instance" "shadow-vm" {
  ami           = "ami-0d24c0a5692fe1184"
  associate_public_ip_address = true
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-sa-east-1a.id
  # key_name = ""
  # vpc_id = aws_vpc.crossroads-vpc.id
  vpc_security_group_ids = [aws_security_group.ping.id, aws_security_group.shadow-sg.id]
  user_data = file("./startup.sh")

  tags = {
    Name = "shadow-vm"
    Env     = "Test" 
  }
}