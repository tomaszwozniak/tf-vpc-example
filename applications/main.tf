resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "example.com"
  type    = "A"

  alias {
    name                   = aws_elb.web.dns_name
    zone_id                = aws_elb.web.zone_id
    evaluate_target_health = true
  }
}


resource "aws_alb" "web" {
  name = "${var.name}-alb"

  # The same availability zone as our instance
  subnets = [var.public_subnet_id_primary, var.public_subnet_id_secondary]

  security_groups = [var.alb_sg_id]
  internal           = false
  load_balancer_type = "application"
}


resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web.arn
  }
}


resource "aws_alb_target_group_attachment" "alb_target_group" {
  target_group_arn = aws_alb_target_group.web.arn
  target_id        = aws_instance.web.id
  port             = 80
}


resource "aws_alb_target_group" "web" {
  name     = "${var.name}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


resource "aws_instance" "web" {
  instance_type = "t2.micro"

  # Lookup the correct AMI based on the region
  # we specified
  ami = lookup(var.aws_amis, var.aws_region)

  key_name = var.key_name

  # Our Security group to allow HTTP access
  vpc_security_group_ids = [var.web_sg_id]
  subnet_id              = var.private_subnet_id

  #Instance tags
  tags = {
    Name = "${var.name}-web"
  }
}


resource "aws_instance" "bastion" {
  instance_type = "t2.micro"

  # Lookup the correct AMI based on the region
  # we specified
  ami = lookup(var.aws_amis, var.aws_region)

  key_name = var.key_name

  # Our Security group to allow SSH access
  vpc_security_group_ids = [var.bastion_sg_id]
  subnet_id              = var.public_subnet_id_primary

  # Instance tags
  tags = {
    Name = "${var.name}-bastion"
  }
}


output "dns_name" {
  value = aws_alb.web.dns_name
}
