resource "aws_security_group" "private-sg" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    name = "Private Subnet SG"
    description = "Private Subnet Security Group"
}

resource "aws_security_group_rule" "allow_all_in" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 0
  to_port           = 65535
  security_group_id = "${aws_security_group.private-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_out" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 0
  to_port           = 65535
  security_group_id = "${aws_security_group.private-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}
