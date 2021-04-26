data "aws_route53_zone" "r53_zone_name" {
  name = "${var.env_name}.${var.r53_domain_name}"
  private_zone = false
}