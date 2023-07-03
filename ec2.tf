# Creating EC2 instances
resource "aws_instance" "BastionHost" {
  ami                         = "ami-04cebc8d6c4f297a3"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.bastionhost_keypair.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.Bastion-sg.id}"]
  subnet_id                   = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true
tags = {
  Name = "Bastion Host"
}
}

resource "aws_instance" "WebServer" {
  ami                         = "ami-04cebc8d6c4f297a3"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.webserver_keypair.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.WebServer-sg.id}"]
  subnet_id                   = "${aws_subnet.application-subnet-1.id}"
  associate_public_ip_address = false
tags = {
  Name = "Web Server"
}
}




