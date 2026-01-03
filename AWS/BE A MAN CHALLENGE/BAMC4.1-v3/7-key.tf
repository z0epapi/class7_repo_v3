##-- Register the public key in AWS as a Key Pair --##
resource "aws_key_pair" "bamc-key-pair" {
  key_name   = "bamc-keys"
  public_key = tls_private_key.bamc-keys.public_key_openssh
}


##-- Creates an SSH key pair locally --##
resource "tls_private_key" "bamc-keys" { # Uses the TLS Terraform provider
  algorithm = "RSA"
  rsa_bits  = 4096
}

#############################################################
##-- Generate 2 keys: a public and private locally (0600)--##
#############################################################

# Creates a local file within the current directory -- appears after 'spply' disappears after 'destroy'
resource "local_file" "ec2_private_key" {
  content         = tls_private_key.bamc-keys.private_key_pem
  filename        = "${path.module}/bamc-private.pem" # Tells you where the file name is and where it lives -- (path.module == current folder)
  file_permission = "0600"
}

resource "local_file" "ec2_public_key" {
  content         = tls_private_key.bamc-keys.public_key_pem
  filename        = "${path.module}/bamc-public.pem" # Tells you where the file name is and where it lives -- (path.module == current folder)
  file_permission = "0600"
}