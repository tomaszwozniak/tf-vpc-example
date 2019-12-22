variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  type        = string
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-central-1"
  type        = string
}

variable "name" {
  type = string
}

# can be changed to get it automatically
variable "aws_amis" {
  default = {
    "eu-central-1" = "ami-0cc0a36f626a4fdf5"
  }
}

variable "zone_id" {
  type = string
}