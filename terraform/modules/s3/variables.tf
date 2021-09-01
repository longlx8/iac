# khai báo các biến truyền vào s3 module để tạo bucket

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}

# https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#canned-acl
variable "bucket_acl" {
    description = "The canned ACL apply to bucket."
    type = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
