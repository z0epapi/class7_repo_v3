resource "aws_vpc" "anansi" {
  cidr_block           = "10.80.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name         = "Anansi"
    Envirionment = "Test"
    Service      = "Networking"
  }
}