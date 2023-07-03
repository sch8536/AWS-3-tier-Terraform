# Creating Security Group for Bastion Host
resource "aws_security_group" "Bastion-sg" {
  vpc_id = "${aws_vpc.PROmet-VPC.id}"

# SSH access from anywhere
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
# Outbound Rules
# Internet access to anywhere
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
tags = {
  Name = "Bastion Host SG"
}
}

# Web Server Security Group
resource "aws_security_group" "WebServer-sg" {
  vpc_id = "${aws_vpc.PROmet-VPC.id}"

# SSH access from anywhere
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Outbound Rules
# Internet access to anywhere
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
tags = {
  Name = "WebServer SG"
}
}

# Database Security Group
resource "aws_security_group" "DB-sg" {
  name        = "Database SG"
  description = "Allow inbound traffic from application layer"
  vpc_id      = "${aws_vpc.PROmet-VPC.id}"
ingress {
  description     = "Allow traffic from application layer"
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  security_groups = ["${aws_security_group.WebServer-sg.id}"]
}
ingress {
  description     = "Allow traffic from bastion host"
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  security_groups = ["${aws_security_group.Bastion-sg.id}"]
}
tags = {
  Name = "Database SG"
}
}


# ALB Security Group
resource "aws_security_group" "ALB-sg" {
  vpc_id = "${aws_vpc.PROmet-VPC.id}"

# SSH access from anywhere
ingress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  security_groups = ["${aws_security_group.WebServer-sg.id}"]
}

tags = {
  Name = "ALB SG"
}
}

# EFS Security Group
resource "aws_security_group" "EFS-sg" {
  vpc_id = "${aws_vpc.PROmet-VPC.id}"

# SSH access from anywhere
ingress {
  from_port   = 2049
  to_port     = 2049
  protocol    = "tcp"
  security_groups = ["${aws_security_group.WebServer-sg.id}"]
}

tags = {
  Name = "EFS SG"
}
}

