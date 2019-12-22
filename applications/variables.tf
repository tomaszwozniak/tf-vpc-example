variable "name" {
  type = string
}
variable "key_name" {
  type = string
}
variable "aws_amis" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "public_subnet_id_secondary" {
  type = string
}
variable "public_subnet_id_primary" {
  type = string
}
variable "alb_sg_id" {
  type = string
}
variable "web_sg_id" {
  type = string
}
variable "private_subnet_id" {
  type = string
}
variable "bastion_sg_id" {
  type = string
}
variable "vpc_id" {
  type = string
}
