# Creating Route Table
resource "aws_route_table" "Priv-Sub" {
  vpc_id = "${aws_vpc.PROmet-VPC.id}"

route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_nat_gateway.PROmet-ngw.id}"
  }
tags = {
      Name = "Route to NAT Gateway"
  }
}

resource "aws_route_table_association" "rt3" {
  subnet_id = "${aws_subnet.application-subnet-1.id}"
  route_table_id = "${aws_route_table.Priv-Sub.id}"
}

resource "aws_route_table_association" "rt4" {
  subnet_id = "${aws_subnet.application-subnet-2.id}"
  route_table_id = "${aws_route_table.Priv-Sub.id}"
}

resource "aws_route_table_association" "rt5" {
  subnet_id = "${aws_subnet.database-subnet-1.id}"
  route_table_id = "${aws_route_table.Priv-Sub.id}"
}

resource "aws_route_table_association" "rt6" {
  subnet_id = "${aws_subnet.database-subnet-2.id}"
  route_table_id = "${aws_route_table.Priv-Sub.id}"
}

