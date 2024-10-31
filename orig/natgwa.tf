resource "aws_internet_gateway" "internet_gw" {
  vpc_id = "${aws_vpc.vpc-prod.id}"
  tags = {
    "Name" = "InternetGateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.vpc-prod.id}"
  tags = {
    "Name" = "RouteTable"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gw.id}"
  }
}

resource "aws_route_table_association" "route_table_assA1" {
  subnet_id = "${aws_subnet.sub-prod-azA-pub.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}

resource "aws_eip" "elastic_ip" {
  vpc = true
}

resource "aws_nat_gateway" "natgwA" {
  allocation_id = "${aws_eip.elastic_ip.id}"
  subnet_id = "${aws_subnet.sub-prod-azA-pub.id}"

  tags = {
    "Name" = "NAT Gateway A"
  }
}

resource "aws_route_table" "nat_routeA" {
  vpc_id = "${aws_vpc.vpc-prod.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgwA.id}"
  }
  tags = {
    "Name" = "NAT Route Table A"
  }
}

resource "aws_route_table_association" "route_table_assA2" {
  subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
  route_table_id = "${aws_route_table.nat_routeA.id}"
}