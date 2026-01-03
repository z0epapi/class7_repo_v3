######################
### Bastion Server ###
######################

# AMI Data block to make code more resuable instead of being hard-coded
# The Data block is found under the the CPU options in the aws_instance subsection in the Terrafrom Registry
data "aws_ami" "ms-win-2025-base" {
  most_recent = true       # Use the most recent AMI
  owners      = ["amazon"] # Make sure to keep it as 'amazon' -- always get 'query returned no results' error when using MS owned account ID

  filter {
    name   = "name"
    values = ["Windows_Server-2025-English-Full-Base-*"] # The value is found in the AMI catalog or running instance in instance details section in the  console
  }                                                      # Retuns a broader range of AMIs with * wildcard. 
}

resource "aws_instance" "epstein-bestie" {
  ami                         = data.aws_ami.ms-win-2025-base.id # Used to reference AMI data block
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public-1a.id
  vpc_security_group_ids      = [aws_security_group.bastion-sg01.id]
  key_name = aws_key_pair.kle_legba.key_name # Pairs key name to RDP into Windows

  user_data = file("./startup.sh")

  tags = {
    Name    = "epstein-bestie-jumpbox"
    Service = "test-server"
    Env     = "Test"
  }
}

#####################
### Linux Backend ###
#####################

# AMI Data block to make code more resuable instead of being hard-coded
# The Data block is found under the the CPU options in the aws_instance subsection in the Terrafrom Registry
data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true # Use the most recent AMI
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"] # The value is found in check AMI catalog or running instance in instance details section in the console
  }                                       # Retuns a broader range of AMIs
}

resource "aws_instance" "linux-backend" {
  ami                         = data.aws_ami.amzn-linux-2023-ami.id # Used to reference AMI data block
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private-1a.id
  vpc_security_group_ids      = [aws_security_group.backend-sg02.id]

  user_data = file("./startup.sh")

  tags = {
    Name    = "linux-backend"
    Service = "test-server"
    Env     = "Test"
  }
}