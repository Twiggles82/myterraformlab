resource "aws_security_group" "mgmtad" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    name = "Mgmt and AD"
    description = "Management and AD security group"
}

resource "aws_security_group_rule" "mgmtad_icmp_in" {
  type              = "ingress"
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_1024-65535-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "1024"
  to_port           = "65535"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_1024-65535-UDP-out" {
  type              = "egress"
  protocol          = "UDP"
  from_port         = "1024"
  to_port           = "65535"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_123-UDP-out" {
  type              = "egress"
  protocol          = "UDP"
  from_port         = "123"
  to_port           = "123"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_135-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "135"
  to_port           = "135"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_137-138-UDP-out" {
  type              = "egress"
  protocol          = "UDP"
  from_port         = "137"
  to_port           = "138"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_139-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "139"
  to_port           = "139"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_3268-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "3268"
  to_port           = "3268"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_389-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "389"
  to_port           = "389"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_389-UDP-out" {
  type              = "egress"
  protocol          = "UDP"
  from_port         = "389"
  to_port           = "389"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_445-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "445"
  to_port           = "445"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_445-UDP-out" {
  type              = "egress"
  protocol          = "UDP"
  from_port         = "445"
  to_port           = "445"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_53-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "53"
  to_port           = "53"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_53-UDP-out" {
  type              = "egress"
  protocol          = "UDP"
  from_port         = "53"
  to_port           = "53"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_egress-873-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "873"
  to_port           = "873"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_88-TCP-out" {
  type              = "egress"
  protocol          = "TCP"
  from_port         = "88"
  to_port           = "88"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_88-UDP-out" {
  type              = "egress"
  protocol          = "UDP"
  from_port         = "88"
  to_port           = "88"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_53-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "53"
  to_port           = "53"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_1024-65535-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "1024"
  to_port           = "65535"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_1024-65535-UDP-in" {
  type              = "ingress"
  protocol          = "UDP"
  from_port         = "1024"
  to_port           = "65535"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_123-UDP-in" {
  type              = "ingress"
  protocol          = "UDP"
  from_port         = "123"
  to_port           = "123"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_135-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "135"
  to_port           = "135"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_137-138-UDP-in" {
  type              = "ingress"
  protocol          = "UDP"
  from_port         = "137"
  to_port           = "138"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_139-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "139"
  to_port           = "139"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_3389-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "3389"
  to_port           = "3389"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_3268-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "3268"
  to_port           = "3268"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_389-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "389"
  to_port           = "389"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_389-UDP-in" {
  type              = "ingress"
  protocol          = "UDP"
  from_port         = "389"
  to_port           = "389"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_ingress-445-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "445"
  to_port           = "445"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_ingress-445-UDP-in" {
  type              = "ingress"
  protocol          = "UDP"
  from_port         = "445"
  to_port           = "445"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_53-UDP-in" {
  type              = "ingress"
  protocol          = "UDP"
  from_port         = "53"
  to_port           = "53"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_873-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "873"
  to_port           = "873"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_88-TCP-in" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "88"
  to_port           = "88"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "mgmtad_88-UDP-in" {
  type              = "ingress"
  protocol          = "UDP"
  from_port         = "88"
  to_port           = "88"
  security_group_id = "${aws_security_group.mgmtad.id}"
  cidr_blocks       = ["10.0.0.0/8"]
}