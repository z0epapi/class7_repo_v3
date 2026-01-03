# output "instance_ip" {
#   value = "http://${aws_instance.crossroads-server.public_ip}"
# }

output "sample" {
  description = "demo for output"
  value       = "sample"
}

# output "ip_address" {
#   value = aws_instance.shadow-vm.associate_public_ip_address
# }

# output "website_url" {
#   value = "http://${aws_instance.shadow-vm.public_dns}"
# }

# output "load_balancer_dns" {
#   value = "http://${aws_lb.shadow-alb.dns_name}"
# }