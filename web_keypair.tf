resource "tls_private_key" "webserver" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "webserver_keypair" {
  key_name   = "WebServer"
  public_key = "${tls_private_key.webserver.public_key_openssh}"
}

resource "local_file" "WebServer-Key"{
  content = "${tls_private_key.webserver.private_key_pem}"
  filename = "WebServerKey"
}


