variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
    default = "ap-northeast-1"
}
variable "aws_zone" {
    default = "ap-northeast-1c"
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
}

resource "aws_vpc" "myVPC" {
    cidr_block = "10.4.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "false"
    tags {
        Name = "myVPC"
    }
}
