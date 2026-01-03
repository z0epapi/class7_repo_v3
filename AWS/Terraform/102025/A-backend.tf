terraform {
  backend "s3" {
    bucket = "class7-demo-backend"
    key    = "HungreyWolves"
    region = "us-east-1"
  }
}