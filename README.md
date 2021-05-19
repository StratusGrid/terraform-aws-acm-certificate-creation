###Example Usage
```
variable "acm_domain_name" {
  description = "Certificate name prefix trailed by hosted zone name"
  type = list(string)
}

variable "hosted_zone_name" {
  description = "Route53 hosted zone name"
  type        = string
}

acm_domain_name   = ["foo", "bar"]
hosted_zone_name  = "engineering.example.com"
```
```
data "aws_route53_zone" "hosted_zone_id" {
  name = var.hosted_zone_name
  private_zone = false
}
```
```
module "new_certificate" {
  source = "github.com/StratusGrid/terraform-aws-acm-certificate-creation"

  for_each        = toset(var.acm_domain_name)
  acm_domain_name = "${each.key}.${var.hosted_zone_name}"
  zone_id         = data.aws_route53_zone.hosted_zone_id.zone_id

  input_tags      = {
    "Name" = "${each.key}.${var.hosted_zone_name}"
    }
}
```