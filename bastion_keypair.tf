resource "tls_private_key" "bastionhost" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastionhost_keypair" {
  key_name   = "BastionHost"
  public_key = "${tls_private_key.bastionhost.public_key_openssh}"
}

resource "local_file" "BastionHost-Key"{
  content = "${tls_private_key.bastionhost.private_key_pem}"
  filename = "BastionHostKey"
}

