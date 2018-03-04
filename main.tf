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

resource "aws_ecs_cluster" "api_cluster" {
    name = "api_cluster"
}
