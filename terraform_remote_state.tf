data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "${var.terraform_state_bucket}"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-1"
  }
}