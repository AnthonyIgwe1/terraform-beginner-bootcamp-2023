  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_example" {
  # Bucket naming rules
  # https://s3.console.aws.amazon.com/s3/bucket/create?region=us-east-2
  bucket = var.bucket_name

tags = {
    UserUuid =var.user_uuid
  }
}

