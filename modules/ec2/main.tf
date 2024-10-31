data "local_file" "desktop_requirements" {
  filename = "${path.module}/user-data-config/requirements.txt"
}

data "template_file" "desktop_prep" {
  template = "${file("${path.module}/user-data-config/PrepDesktop.ps1")}"

  vars = {
    requirements_txt = data.local_file.desktop_requirements.content
  }
}

resource "aws_instance" "desktopred" {
  associate_public_ip_address = false
  ami = "${var.usz_desktop_ami}"
  instance_type = "${var.desktop_instance_type}"
  availability_zone = "${var.desktop_availability_zone}"
  key_name = "${var.key_pair}"
  get_password_data = true
  iam_instance_profile = "${aws_iam_instance_profile.aws_mgmt_instance_profile.id}"
  user_data = "${data.template_file.desktop_prep.rendered}"
  subnet_id = "${aws_subnet.private-subnet-euw2a.id}"
  ebs_optimized = true
  root_block_device {
      encrypted = true
      volume_size = "${var.desktop_root_ebs_size}"
      volume_type = "${var.desktop_root_ebs_type}"
      }
  metadata_options { 
     http_tokens = "required" 
     http_endpoint = "enabled" 
  } 

  vpc_security_group_ids = [
     "${aws_security_group.private-security-group.id}"
  ]

  # Add tags:
  tags = {
     Name = "${var.tf_project_code}-1z"
     Zone = "${var.tf_project_code}-2y"
  }
}

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