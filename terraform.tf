terraform {
  required_version = "0.12.18"
  backend "s3" {
    encrypt = true
  }
}
