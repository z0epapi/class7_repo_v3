##-- Creates SSH key pair --##
resource "aws_key_pair" "kle_legba" {
  key_name   = "kle_legba"
  public_key = tls_private_key.kle_kalfou.public_key_openssh
}

###############################################
##-- Generate 2 keys: a public and private --##
###############################################
# Creates RSA key of tsize 4096 bits
resource "tls_private_key" "kle_kalfou" { # Uses the TLS Terraform provider
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Creates a local file withing the current directory -- appears after 'spply' disappears after 'destroy'
resource "local_file" "ec2_private_key" {
  content         = tls_private_key.kle_kalfou.private_key_pem
  filename        = "${path.module}/kle-prive.pem" # Tells you where the file name is and where it lives -- (path.module == current folder)
  file_permission = "0600"
}

resource "local_file" "ec2_public_key" {
  content         = tls_private_key.kle_kalfou.public_key_pem
  filename        = "${path.module}/kle-publik.pem" # Tells you where the file name is and where it lives -- (path.module == current folder)
  file_permission = "0600"
}