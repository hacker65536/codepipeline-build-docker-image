resource "aws_s3_bucket" "s3" {
  bucket_prefix = "${terraform.env}-"
  acl           = "private"
  force_destroy = true
  tags          = "${var.tags}"
}
