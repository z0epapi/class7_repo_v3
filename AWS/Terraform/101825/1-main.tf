# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.80.0.0/16"

  tags = {
    Name = "demo-vpc-terraform"
  }
}