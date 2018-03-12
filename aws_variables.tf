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
variable "aws_ecs_service_desired_count_rails" { default = 1 }

#Segment Settings
variable "root_segment" {}
variable "public_segment1" {}
variable "public_segment2" {}

#AZ Settings
variable "public_segment1_az" {}
variable "public_segment2_az" {}

#SG Settings
variable "ssh_allow_ip" {}

#DB Settings
variable "db_user" {}
variable "db_pass" {}
variable "db_instance_class" {}

#App Settings
variable "secret_key_base" {}
