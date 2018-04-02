data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "terraform-state-dev"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-1"
  }
}