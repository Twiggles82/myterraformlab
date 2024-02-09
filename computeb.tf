#### Data source is used to do something then give you data ####

# Find the latest available AMI that is Amazon created and contains 'Windows_Server-2019-English-Full-Base-' in the name and we'll refer to is as 'windowsfilter-A'
/*data "aws_ami" "windowsfilter-B" {
     most_recent = true   
     owners = ["amazon"]

filter {
       name   = "name"
       values = ["*Windows_Server-2019-English-Full-Base-*"]
       }
}

 resource "aws_instance" "jumpserver-B" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter-B.id}"
     subnet_id = "${aws_subnet.sub-prod-azB-pub.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.home-sg.id}", "${aws_security_group.external-sg.id}"] 
     
         tags = {
         Name = "jumpserver-B"
     }
 }

  resource "aws_instance" "UsersDC-B" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter-B.id}"
     subnet_id = "${aws_subnet.sub-prod-azB-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "UsersDC-B"
     }
 }

  resource "aws_instance" "WorkstationsDC-B" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter-B.id}"
     subnet_id = "${aws_subnet.sub-prod-azB-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "WorkstationsDC-B"
     }
 }

 resource "aws_instance" "certauth-B" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter-B.id}"
     subnet_id = "${aws_subnet.sub-prod-azB-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "certauth-B"
     }
 }

 resource "aws_instance" "ocsp-B" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter-B.id}"
     subnet_id = "${aws_subnet.sub-prod-azB-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "ocsp-B"

     }
 }

 resource "aws_instance" "BDFS-B" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter-B.id}"
     subnet_id = "${aws_subnet.sub-prod-azB-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "BDFS-B"

     }
 }
 */