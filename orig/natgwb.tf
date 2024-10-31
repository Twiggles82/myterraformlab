resource "aws_route_table_association" "route_table_assB1" {
  subnet_id = "${aws_subnet.sub-prod-azB-pub.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}

resource "aws_eip" "elastic_ipB" {
  vpc = true
}

resource "aws_nat_gateway" "natgwB" {
  allocation_id = "${aws_eip.elastic_ipB.id}"
  subnet_id = "${aws_subnet.sub-prod-azB-pub.id}"

  tags = {
    "Name" = "NAT Gateway B"
  }
}

resource "aws_route_table" "nat_routeB" {
  vpc_id = "${aws_vpc.vpc-prod.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgwB.id}"
  }
  tags = {
    "Name" = "NAT Route Table B"
  }
}

resource "aws_route_table_association" "route_table_assB2" {
  subnet_id = "${aws_subnet.sub-prod-azB-priv.id}"
  route_table_id = "${aws_route_table.nat_routeB.id}"
}