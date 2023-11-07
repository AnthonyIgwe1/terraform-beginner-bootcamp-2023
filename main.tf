# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower   = true
  upper   = false
  length  = 32
  special = false
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  # Bucket naming rules
  # https://s3.console.aws.amazon.com/s3/bucket/create?region=us-east-2
  bucket = random_string.bucket_name.result

tags = {
    UserUuid =var.user_uuid
  }
}
