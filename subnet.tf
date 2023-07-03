# Creating 1st Public subnet 
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = "${aws_vpc.PROmet-VPC.id}"
  cidr_block             = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2a"
tags = {
  Name = "Bastion Host"
}
}
# Creating 2nd Public subnet 
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = "${aws_vpc.PROmet-VPC.id}"
  cidr_block             = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2c"
tags = {
  Name = "Only NAT Gateway"
}
}
# Creating WAS Private subnet 1
resource "aws_subnet" "application-subnet-1" {
  vpc_id                  = "${aws_vpc.PROmet-VPC.id}"
  cidr_block             = "${var.subnet2_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-2a"
tags = {
  Name = "WAS Subnet 1"
}
}
# Creating WAS Private subnet 2
resource "aws_subnet" "application-subnet-2" {
  vpc_id                  = "${aws_vpc.PROmet-VPC.id}"
  cidr_block             = "${var.subnet3_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-2c"
tags = {
  Name = "WAS Subnet 2"
}
}
# Create Database Private Subnet 1
resource "aws_subnet" "database-subnet-1" {
  vpc_id            = "${aws_vpc.PROmet-VPC.id}"
  cidr_block        = "${var.subnet4_cidr}"
  availability_zone = "ap-northeast-2a"
tags = {
  Name = "Master DB Subnet"
}
}
# Create Database Private Subnet 2
resource "aws_subnet" "database-subnet-2" {
  vpc_id            = "${aws_vpc.PROmet-VPC.id}"
  cidr_block        = "${var.subnet5_cidr}"
  availability_zone = "ap-northeast-2c"
tags = {
  Name = "Slave DB Subnet"
}
}


