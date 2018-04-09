#####################################
# Variable Settings
#####################################
#AWS Settings
variable "account_id" {}
variable "access_key" {}
variable "secret_key" {}
variable "region" {}

#App Name
variable "app_identity_name" {}
variable "app_base_name" {}
variable "aws_ecs_service_desired_count_rails" {}

#Segment Settings
variable "root_segment" {}
variable "public_segment1" {}
variable "public_segment2" {}
variable "private_segment1" {}
variable "private_segment2" {}

#AZ Settings
variable "public_segment1_az" {}
variable "public_segment2_az" {}
variable "private_segment1_az" {}
variable "private_segment2_az" {}

#SG Settings
variable "ssh_allow_ip" {}

#DB Settings
variable "db_user" {}
variable "db_pass" {}
variable "db_instance_class" {}

#App Settings
variable "secret_key_base" {}
variable "key_name" {}
variable "deployer_public_key" {}
variable "deployer_private_key" {}
variable "autoscaling_group_desired_capacity" {}
variable "autoscaling_group_max_size" {}
variable "autoscaling_group_min_size" {}
variable "launch_configuration_image_id" {}
variable "launch_configuration_instance_type" {}
variable "terraform_state_bucket" {}

#ECS Settings
variable "rails_awslogs_group" {}
variable "rails_awslogs_region" {}
variable "rails_awslogs_stream_prefix" {}
variable "mysql_database" {}
variable "mysql_username" {}
variable "mysql_password" {}
variable "mysql_host" {}
variable "nginx_awslogs_group" {}
variable "nginx_awslogs_region" {}
variable "nginx_awslogs_stream_prefix" {}
variable "ecs_name_rails" {}
variable "ecs_name_nginx" {}
