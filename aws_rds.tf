#####################################
# DB Instance Settings
#####################################
// FIXME: remove rds from terraform on production
resource "aws_db_instance" "db_instance" {
  allocated_storage          = 20
  auto_minor_version_upgrade = true
  backup_retention_period    = 7
  backup_window              = "20:00-21:00"
  db_subnet_group_name       = "${aws_db_subnet_group.db_subnet_group.name}"
  engine                     = "mysql"
  engine_version             = "5.7.21"
  identifier                 = "${var.app_base_name}"
  instance_class             = "${var.db_instance_class}"
  multi_az                   = false
  name                       = "dbInstance"
  parameter_group_name       = "${aws_db_parameter_group.db_parameter_group.name}"
  password                   = "${var.db_pass}"
  skip_final_snapshot        = true
  username                   = "${var.db_user}"
  vpc_security_group_ids = [
    "${aws_security_group.db_sg.id}"
  ]
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "${var.app_base_name}"
  family = "mysql5.7"
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.app_base_name}"
  description = "${var.app_base_name}"
  subnet_ids = [
    "${aws_subnet.vpc_main-public-subnet1.id}",
    "${aws_subnet.vpc_main-public-subnet2.id}",
  ]
}
