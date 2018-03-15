resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.app_base_name}_bucket"
  acl    = "private"
  tags {
    Name        = "${var.app_base_name}"
    Environment = "Dev"
  }
}