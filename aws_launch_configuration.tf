resource "aws_launch_configuration" "launch_configuration" {
  associate_public_ip_address = true
  depends_on                  = ["aws_internet_gateway.vpc_main-igw"]
  iam_instance_profile        = "${aws_iam_instance_profile.iam_instance_profile.id}"
  image_id                    = "${var.launch_configuration_image_id}"
  key_name                    = "${var.key_name}"
  instance_type               = "${var.launch_configuration_instance_type}"
  name_prefix                 = "ecs-"
  security_groups             = ["${aws_security_group.app_sg.id}"]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${aws_ecs_cluster.ecs_cluster.name}' >> /etc/ecs/ecs.config"
}

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