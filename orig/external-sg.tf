resource "aws_security_group" "external-sg" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    name = "external www"
    description = "external WWW security group"
}

resource "aws_security_group_rule" "external_80-TCP-out" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "80"
  to_port           = "80"
  security_group_id = "${aws_security_group.external-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "external_443-TCP-out" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "443"
  to_port           = "443"
  security_group_id = "${aws_security_group.external-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "external_53-TCP-out" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "53"
  to_port           = "53"
  security_group_id = "${aws_security_group.external-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "external_53-UDP-out" {
  type              = "egress"
  protocol          = "UDP"
  from_port         = "53"
  to_port           = "53"
  security_group_id = "${aws_security_group.external-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "external_icmp_out" {
  type              = "egress"
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  security_group_id = "${aws_security_group.external-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "external_21-22-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "21"
  to_port           = "22"
  security_group_id = "${aws_security_group.external-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "external_5985-TCP-out" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "5985"
  to_port           = "5985"
  security_group_id = "${aws_security_group.external-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "external_5986-TCP-out" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "5986"
  to_port           = "5986"
  security_group_id = "${aws_security_group.external-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}