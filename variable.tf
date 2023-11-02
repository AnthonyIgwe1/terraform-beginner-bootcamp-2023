variable "user_uuid" {
  type    = string
  default = "24eecd4c-e2ad-488d-ac62-5f116a250ee1"
}

variable "bucket_name" {
  description = "The name of the AWS S3 bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]+$", var.bucket_name))
    error_message = "Bucket name must consist of lowercase letters, numbers, hyphens, and periods only."
  }
}
