output "instance_ip" {
  value = "http://${aws_instance.example.public_ip}"
}