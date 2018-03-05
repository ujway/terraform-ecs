#####################################
# Variable Settings
#####################################
#AWS Settings
variable "access_key" {}
variable "secret_key" {}
variable "region" {}

#App Name
variable "app_name" {}

#Segment Settings
variable "root_segment" {}
variable "public_segment1" {}
variable "public_segment2" {}

#AZ Settings
variable "public_segment1_az" {}
variable "public_segment2_az" {}

#SG Settings
variable "ssh_allow_ip" {}
