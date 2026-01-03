# VPC resource
# This creates the virtual private cloud
resource "aws_vpc" "office-hours-vpc" {
  
  # region = ""
  
  cidr_block           = "10.80.0.0/16" 
  enable_dns_hostnames = true 
  enable_dns_support = true 

  tags = {
    Name = "office-hours-vpc"
  }

}