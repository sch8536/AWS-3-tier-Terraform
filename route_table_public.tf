# Creating Route Table
resource "aws_route_table" "Public-Sub" {
  vpc_id = "${aws_vpc.PROmet-VPC.id}"
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.PROmet-IGW.id}"
  }
tags = {
      Name = "Route to internet"
  }
}

resource "aws_route_table_association" "rt1" {
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  route_table_id = "${aws_route_table.Public-Sub.id}"
}

resource "aws_route_table_association" "rt2" {
  subnet_id = "${aws_subnet.public-subnet-2.id}"
  route_table_id = "${aws_route_table.Public-Sub.id}"
}

