variable "s3_terraform_bucket" {
  type = string
  default = "tw-terraform-remote-state-storage-s3"
}

variable "dynamodb_table" {
  type = string
  default = "tw-terraform-state-lock-dynamo"
}
