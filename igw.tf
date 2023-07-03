# Creating Internet Gateway 
resource "aws_internet_gateway" "PROmet-IGW" {
  vpc_id = "${aws_vpc.PROmet-VPC.id}"
}

