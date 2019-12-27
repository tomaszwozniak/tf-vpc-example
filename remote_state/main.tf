provider "aws" {
  region = "eu-central-1"
  version = "2.43.0"
}

resource "aws_s3_bucket" "tw-terraform-state-storage-s3" {
    bucket = var.s3_terraform_bucket

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags = {
      Name = "S3 Remote Terraform State Store"
    }
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = var.dynamodb_table
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
