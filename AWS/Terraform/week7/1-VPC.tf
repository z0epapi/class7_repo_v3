# VPC resource
# This creates the virtual private cloud
resource "aws_vpc" "app1" {
  
  # region = ""
  
  cidr_block           = "10.80.0.0/16"
  
  tags = {
    Name = "demo-vpc"
  }

}