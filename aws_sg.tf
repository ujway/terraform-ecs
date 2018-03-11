#####################################
# Security Group Settings
#####################################
resource "aws_security_group" "alb_sg" {
  name = "ALB_SG"
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
  description = "${var.app_identity_name} ALB SG"
}

resource "aws_security_group" "app_sg" {
  name = "APP_SG"
  vpc_id = "${aws_vpc.vpc_main.id}"
  ingress {
    from_port = 0
    to_port = 65535
//    from_port = 8080
//    to_port = 8080
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
  description = "${var.app_identity_name} APP SG"
}

resource "aws_security_group" "db_sg" {
  name = "DB_SG"
  vpc_id = "${aws_vpc.vpc_main.id}"
  ingress {
    from_port = 0
    to_port = 65535
    //    from_port = 8080
    //    to_port = 8080
    protocol = "tcp"
    security_groups = ["${aws_security_group.app_sg.id}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "${var.app_identity_name} DB SG"
}
