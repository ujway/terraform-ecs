#####################################
# Security Group Settings
#####################################
resource "aws_security_group" "elb_sg" {
  name = "ELB_SG"
  vpc_id = "${aws_vpc.vpc_main.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "${var.app_name} ELB SG"
}

resource "aws_security_group" "app_sg" {
  name = "APP_SG"
  vpc_id = "${aws_vpc.vpc_main.id}"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb_sg.id}"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.ssh_allow_ip}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "${var.app_name} APP SG"
}
