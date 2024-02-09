#### Data source is used to do something then give you data ####

# Find the latest available AMI that is Amazon created and contains 'Windows_Server-2019-English-Full-Base-' in the name and we'll refer to is as 'windowsfilter-A'
data "aws_ami" "windowsfilter" {
     most_recent = true   
     owners = ["amazon"]

filter {
       name = "name"
       values = ["Windows_Server-2022-English-Full-Base*"]
       }
}

resource "aws_instance" "jumpserverSG1" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-pub.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.home-sg.id}", "${aws_security_group.external-sg.id}"] 
         tags = {
         Name = "jumpserverSG1"
         DeviceId = "jumpserverSG1"
     }
 }

resource "aws_instance" "jenkins" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]
         tags = {
         Name = "jenkins"
         DeviceId = "jenkins"
     }
 }

resource "aws_instance" "ad-root" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "ad-root"
         DeviceId = "ad-root"
     }
 }

resource "aws_instance" "ad-comp" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "ad-comp"
         DeviceId = "ad-comp"
     }
 }

resource "aws_instance" "ad-user" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "ad-user"
         DeviceId = "ad-user"
     }
 }

resource "aws_instance" "ca-comp" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "ca-comp"
         DeviceId = "ca-comp"
     }
 }

resource "aws_instance" "ca-user" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "ca-user"
         DeviceId = "ca-user"
     }
 }

resource "aws_instance" "ocsp-comp" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "ocsp-comp"
         DeviceId = "ocsp-comp"
     }
 } 

resource "aws_instance" "ocsp-user" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "ocsp-user"
         DeviceId = "ocsp-user"
     }
 } 

resource "aws_instance" "comp-desktop" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "comp-desktop"
         DeviceId = "comp-desktop"
     }
 }

resource "aws_instance" "user-desktop" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.windowsfilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("./scripts/windowscustomise.ps1")
     vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

         tags = {
         Name = "user-desktop"
         DeviceId = "user-desktop"
     }
 }

data "aws_ami" "ubuntufilter" { 
     most_recent = true
     owners = ["099720109477"]

filter {
       name   = "name"
       values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20220411*"]
       }
}

resource "aws_instance" "DockerInstance" {
   instance_type = "t3.medium"
     ami = "${data.aws_ami.ubuntufilter.id}"
     subnet_id = "${aws_subnet.sub-prod-azA-pub.id}"
     key_name = "${var.key_name}"
     iam_instance_profile = "${var.ec2_profile}"
     vpc_security_group_ids = ["${aws_security_group.home-sg.id}", "${aws_security_group.external-sg.id}"] 
     
         tags = {
         Name = "DockerInstance"
         DeviceId = "DockerInstance"
     }
 }

resource "local_file" "ans-inventory" {
  filename = "C:\\temp\\demo\\new-sandpit\\hosts"
  content  = <<EOF
[ad-root]
${aws_instance.ad-root.private_ip}

[ad-comp]
${aws_instance.ad-comp.private_ip}

[ad-user]
${aws_instance.ad-user.private_ip}

[ca-comp]
${aws_instance.ca-comp.private_ip}

[ca-user]
${aws_instance.ca-user.private_ip}

[ocsp-comp]
${aws_instance.ocsp-comp.private_ip}

[ocsp-user]
${aws_instance.ocsp-user.private_ip}

[comp-desktop]
${aws_instance.comp-desktop.private_ip}

[user-desktop]
${aws_instance.user-desktop.private_ip}

EOF
}


resource "local_file" "excel-inv" {
  filename = "C:\\temp\\demo\\new-sandpit\\excel-inv.csv"
  content  = <<EOF
ad-root,${aws_instance.ad-root.private_ip}

ad-comp,${aws_instance.ad-comp.private_ip}

ad-user,${aws_instance.ad-user.private_ip}

ca-comp,${aws_instance.ca-comp.private_ip}

ca-user,${aws_instance.ca-user.private_ip}

ocsp-comp,${aws_instance.ocsp-comp.private_ip}

ocsp-user,${aws_instance.ocsp-user.private_ip}

comp-desktop,${aws_instance.comp-desktop.private_ip}

user-desktop,${aws_instance.user-desktop.private_ip}

EOF
}