resource "aws_eip" "PROmet-nip"{
  vpc = true
  tags = {
    Name = "PROmet-nip"
  }
}

resource "aws_nat_gateway" "PROmet-ngw"{
  allocation_id = "${aws_eip.PROmet-nip.id}"
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  tags = {
    Name = "PROmet-ngw"
  }
}

