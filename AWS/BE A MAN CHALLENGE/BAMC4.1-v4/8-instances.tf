######################
### Bastion Server ###
######################

# AMI Data block to make code more resuable instead of being hard-coded
# The Data block is found under the the CPU options in the aws_instance subsection in the Terrafrom Registry
data "aws_ami" "ms-win-2025-base" {
  most_recent = true       # Use the most recent AMI
  owners      = ["amazon"] # Make sure to keep it as 'amazon' -- always get 'query returned no results' error when using MS owned account ID

  filter {
    name   = "name"
    values = ["Windows_Server-2025-English-Full-Base-*"] # The value is found in the AMI catalog or running instance in instance details section in the  console
  }                                                      # Retuns a broader range of AMIs with * wildcard. 
}

resource "aws_instance" "epstein-bestie" {
  ami                         = data.aws_ami.ms-win-2025-base.id # Used to reference AMI data block
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public-1a.id
  vpc_security_group_ids      = [aws_security_group.bastion-sg01.id]
  key_name                    = aws_key_pair.bamc-key-pair.key_name # Pairs key name to RDP into Windows

  user_data = <<EOF
<powershell>
$ErrorActionPreference = "Stop"

# Install OpenSSH Client if missing (Windows Server 2019/2022)
$capName = "OpenSSH.Client~~~~0.0.1.0"
$cap = Get-WindowsCapability -Online | Where-Object { $_.Name -eq $capName }

if ($cap -and $cap.State -ne "Installed") {
  Add-WindowsCapability -Online -Name $capName | Out-Null
}

# Create .ssh directory
$sshDir = "C:\\Users\\Administrator\\.ssh"
New-Item -ItemType Directory -Force -Path $sshDir | Out-Null

# Write private key (PEM) to id_rsa
$keyPath = Join-Path $sshDir "id_rsa"

$privateKeyPem = @'
${tls_private_key.bamc-keys.private_key_pem}
'@

# Write as ASCII to avoid BOM/unicode issues
[System.IO.File]::WriteAllText($keyPath, $privateKeyPem, [System.Text.Encoding]::ASCII)

# Lock down permissions (OpenSSH is picky)
icacls $keyPath /inheritance:r | Out-Null
icacls $keyPath /grant:r "Administrator:F" | Out-Null

Write-Output "OpenSSH client ready; private key written to $keyPath"
</powershell>
EOF


  tags = {
    Name    = "epstein-bestie-jumpbox"
    Service = "test-server"
    Env     = "Test"
  }
}

#######################
### Linux Backend 1 ###
#######################

# AMI Data block to make code more resuable instead of being hard-coded
# The Data block is found under the the CPU options in the aws_instance subsection in the Terrafrom Registry
data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true # Use the most recent AMI
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"] # The value is found in check AMI catalog or running instance in instance details section in the console
  }                                       # Retuns a broader range of AMIs
}

resource "aws_instance" "linux-backend-01" {
  ami                         = data.aws_ami.amzn-linux-2023-ami.id # Used to reference AMI data block
  associate_public_ip_address = false
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private-1a.id
  vpc_security_group_ids      = [aws_security_group.backend-sg02.id]
  key_name                    = aws_key_pair.bamc-key-pair.key_name # Pairs key name to SSH into Linux

  user_data = file("./startup-01.sh")

  tags = {
    Name    = "linux-backend-01"
    Service = "test-server"
    Env     = "Test"
  }
}

#######################
### Linux Backend 2 ###
#######################

resource "aws_instance" "linux-backend-02" {
  ami                         = data.aws_ami.amzn-linux-2023-ami.id # Used to reference AMI data block
  associate_public_ip_address = false
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private-1b.id
  vpc_security_group_ids      = [aws_security_group.backend-sg02.id]
  key_name                    = aws_key_pair.bamc-key-pair.key_name # Pairs key name to SSH into Linux

  user_data = file("./startup-02.sh")

  tags = {
    Name    = "linux-backend-02"
    Service = "test-server"
    Env     = "Test"
  }
}

#######################
### Linux Backend 3 ###
#######################

resource "aws_instance" "linux-backend-03" {
  ami                         = data.aws_ami.amzn-linux-2023-ami.id # Used to reference AMI data block
  associate_public_ip_address = false
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private-1c.id
  vpc_security_group_ids      = [aws_security_group.backend-sg02.id]
  key_name                    = aws_key_pair.bamc-key-pair.key_name # Pairs key name to SSH into Linux

  user_data = file("./startup-03.sh")

  tags = {
    Name    = "linux-backend-03"
    Service = "test-server"
    Env     = "Test"
  }
}