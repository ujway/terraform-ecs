#####################################
# Cloud Watch Settings
#####################################
resource "aws_cloudwatch_log_group" "cloudwatch" {
  name = "${var.app_base_name}"
}
