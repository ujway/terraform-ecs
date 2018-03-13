resource "aws_launch_configuration" "launch_configuration" {
  associate_public_ip_address = true
  depends_on                  = ["aws_internet_gateway.vpc_main-igw"]
  iam_instance_profile        = "${aws_iam_instance_profile.iam_instance_profile.id}"
  image_id                    = "${var.launch_configuration_image_id}"
  instance_type               = "${var.launch_configuration_instance_type}"
  name_prefix                 = "ecs-"
  security_groups             = ["${aws_security_group.app_sg.id}"]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${aws_ecs_cluster.ecs_cluster.name}' >> /etc/ecs/ecs.config"
}