resource "aws_security_group" "home-sg" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    name = "home only RDP connections"
    description = "connectivity from my specific IPs"
    
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["109.157.61.86/32"]
        description = "all-all"
    }
}