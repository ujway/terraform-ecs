resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity     = "${var.autoscaling_group_desired_capacity}"
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.launch_configuration.name}"
  max_size             = "${var.autoscaling_group_max_size}"
  min_size             = "${var.autoscaling_group_min_size}"
  name                 = "${var.app_base_name}"

  vpc_zone_identifier = [
    "${aws_subnet.vpc_main-public-subnet1.id}",
    "${aws_subnet.vpc_main-public-subnet2.id}"
  ]
}