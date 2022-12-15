#EIP
resource "aws_eip" "ebullion-nat-eip" {
  vpc = true
  tags = tomap({
    Name    = "${var.eip-name}",
    ProvisioningVendor = "${var.vendor}"
  })
}


#NAT GATEWAY
resource "aws_nat_gateway" "ebullion-nat-gw" {
  allocation_id = aws_eip.ebullion-nat-eip.id
  subnet_id     = aws_subnet.ebullion-public-subnet-1.id
  depends_on    = [aws_internet_gateway.ebullion-igw]
  tags = tomap({
    Name    = "${var.nat-name}",
    ProvisioningVendor = "${var.vendor}"
  })
}


#ROUTE TABLE 1
resource "aws_route_table" "ebullion-private-rt-1" {
  vpc_id = aws_vpc.ebullion-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ebullion-nat-gw.id
  }

  tags = tomap({
    Name    = "${var.private-rt-1-name}",
    ProvisioningVendor = "${var.vendor}"
  })
}

#ROUTE TABLE 2
resource "aws_route_table" "ebullion-private-rt-2" {
  vpc_id = aws_vpc.ebullion-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ebullion-nat-gw.id
  }

  tags = tomap({
    Name    = "${var.private-rt-2-name}",
    ProvisioningVendor = "${var.vendor}"
  })
}

#ROUTE TABLE PRIVATE ASSOCIATION 1
resource "aws_route_table_association" "ebullion-private-rt-1-association" {
  subnet_id      = aws_subnet.ebullion-private-subnet-1.id
  route_table_id = aws_route_table.ebullion-private-rt-1.id
}

#ROUTE TABLE PRIVATE ASSOCIATION 2
resource "aws_route_table_association" "ebullion-private-rt-2-association" {
  subnet_id      = aws_subnet.ebullion-private-subnet-2.id
  route_table_id = aws_route_table.ebullion-private-rt-2.id
}


