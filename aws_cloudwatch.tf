#####################################
# Cloud Watch Settings
#####################################
resource "aws_cloudwatch_log_group" "rails_awslogs_group" {
  name = "${var.rails_awslogs_group}",
}

resource "aws_cloudwatch_log_group" "nginx_awslogs_group" {
  name = "${var.nginx_awslogs_group}",
}
