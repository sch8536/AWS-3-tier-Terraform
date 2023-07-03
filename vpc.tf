# Creating VPC
resource "aws_vpc" "PROmet-VPC" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
tags = {
  Name = "PROmet-VPC"
}
}