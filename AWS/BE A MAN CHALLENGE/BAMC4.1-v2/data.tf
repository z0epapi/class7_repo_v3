# data "aws_key_pair" "kle" {
#   key_name           = "kle"
#   include_public_key = true

#   filter {
#     name   = "key_pair_id"
#     values = ["key-0fc7e158035d3a5fc"]
#   }
# }

# output "fingerprint" {
#   value = data.aws_key_pair.kle.fingerprint
# }

# output "name" {
#   value = data.aws_key_pair.kle.key_name
# }

# output "id" {
#   value = data.aws_key_pair.kle.id
# }