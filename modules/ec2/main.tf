data "local_file" "desktop_requirements" {
  filename = "${path.module}/user-data-config/requirements.txt"
}

data "template_file" "desktop_prep" {
  template = "${file("${path.module}/user-data-config/PrepDesktop.ps1")}"

  vars = {
    requirements_txt = data.local_file.desktop_requirements.content
  }
}

resource "aws_instance" "jumpserverSG1" {
   instance_type = "t3.medium"
     ami = "${var.desktop_ami}"
     subnet_id = "${var.subnet_id}"
     key_name = "${var.key_pair}"
     iam_instance_profile = "${var.ec2_profile}"
     user_data = file("/user-data-config/PrepServer.ps1")
     root_block_device {
      encrypted = true
      volume_size = "${var.desktop_root_ebs_size}"
      volume_type = "${var.desktop_root_ebs_type}"
     }
         tags = {
         Name = "jumpserverSG1"
         DeviceId = "jumpserverSG1"
     }
 }

# resource "aws_instance" "jenkins" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]
#          tags = {
#          Name = "jenkins"
#          DeviceId = "jenkins"
#      }
#  }

# resource "aws_instance" "ad-root" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "ad-root"
#          DeviceId = "ad-root"
#      }
#  }

# resource "aws_instance" "ad-comp" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "ad-comp"
#          DeviceId = "ad-comp"
#      }
#  }

# resource "aws_instance" "ad-user" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "ad-user"
#          DeviceId = "ad-user"
#      }
#  }

# resource "aws_instance" "ca-comp" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "ca-comp"
#          DeviceId = "ca-comp"
#      }
#  }

# resource "aws_instance" "ca-user" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "ca-user"
#          DeviceId = "ca-user"
#      }
#  }

# resource "aws_instance" "ocsp-comp" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "ocsp-comp"
#          DeviceId = "ocsp-comp"
#      }
#  } 

# resource "aws_instance" "ocsp-user" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "ocsp-user"
#          DeviceId = "ocsp-user"
#      }
#  } 

# resource "aws_instance" "comp-desktop" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "comp-desktop"
#          DeviceId = "comp-desktop"
#      }
#  }

# resource "aws_instance" "user-desktop" {
#    instance_type = "t3.medium"
#      ami = "${data.aws_ami.windowsfilter.id}"
#      subnet_id = "${aws_subnet.sub-prod-azA-priv.id}"
#      key_name = "${var.key_pair}"
#      iam_instance_profile = "${var.ec2_profile}"
#      user_data = file("./scripts/windowscustomise.ps1")
#      vpc_security_group_ids = ["${aws_security_group.mgmtad.id}", "${aws_security_group.external-sg.id}","${aws_security_group.private-sg.id}"]

#          tags = {
#          Name = "user-desktop"
#          DeviceId = "user-desktop"
#      }
#  }


# resource "local_file" "tf-hosts" {
#   filename = "C:\\repos\\ownrepo\\myterraformlab\\hosts"
#   content  = <<EOF
# [ad-root]
# ${aws_instance.ad-root.private_ip}

# [ad-comp]
# ${aws_instance.ad-comp.private_ip}

# [ad-user]
# ${aws_instance.ad-user.private_ip}

# [ca-comp]
# ${aws_instance.ca-comp.private_ip}

# [ca-user]
# ${aws_instance.ca-user.private_ip}

# [ocsp-comp]
# ${aws_instance.ocsp-comp.private_ip}

# [ocsp-user]
# ${aws_instance.ocsp-user.private_ip}

# [comp-desktop]
# ${aws_instance.comp-desktop.private_ip}

# [user-desktop]
# ${aws_instance.user-desktop.private_ip}

# EOF
# }


# resource "local_file" "ans-hosts" {
#   filename = "C:\\repos\\ownrepo\\myansiblelab\\hosts"
#   content  = <<EOF
# [ad-root]
# ${aws_instance.ad-root.private_ip}

# [ad-comp]
# ${aws_instance.ad-comp.private_ip}

# [ad-user]
# ${aws_instance.ad-user.private_ip}

# [ca-comp]
# ${aws_instance.ca-comp.private_ip}

# [ca-user]
# ${aws_instance.ca-user.private_ip}

# [ocsp-comp]
# ${aws_instance.ocsp-comp.private_ip}

# [ocsp-user]
# ${aws_instance.ocsp-user.private_ip}

# [comp-desktop]
# ${aws_instance.comp-desktop.private_ip}

# [user-desktop]
# ${aws_instance.user-desktop.private_ip}

# EOF
# }

# resource "local_file" "tf-inv-csv" {
#   filename = "C:\\repos\\ownrepo\\myterraformlab\\excel-inv.csv"
#   content  = <<EOF
# ad-root,${aws_instance.ad-root.private_ip}

# ad-comp,${aws_instance.ad-comp.private_ip}

# ad-user,${aws_instance.ad-user.private_ip}

# ca-comp,${aws_instance.ca-comp.private_ip}

# ca-user,${aws_instance.ca-user.private_ip}

# ocsp-comp,${aws_instance.ocsp-comp.private_ip}

# ocsp-user,${aws_instance.ocsp-user.private_ip}

# comp-desktop,${aws_instance.comp-desktop.private_ip}

# user-desktop,${aws_instance.user-desktop.private_ip}

# EOF
# }

# resource "local_file" "ans-inv-csv" {
#   filename = "C:\\repos\\ownrepo\\myansiblelab\\excel-inv.csv"
#   content  = <<EOF
# ad-root,${aws_instance.ad-root.private_ip}

# ad-comp,${aws_instance.ad-comp.private_ip}

# ad-user,${aws_instance.ad-user.private_ip}

# ca-comp,${aws_instance.ca-comp.private_ip}

# ca-user,${aws_instance.ca-user.private_ip}

# ocsp-comp,${aws_instance.ocsp-comp.private_ip}

# ocsp-user,${aws_instance.ocsp-user.private_ip}

# comp-desktop,${aws_instance.comp-desktop.private_ip}

# user-desktop,${aws_instance.user-desktop.private_ip}

# EOF
# }