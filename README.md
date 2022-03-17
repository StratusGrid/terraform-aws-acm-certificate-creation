# ACM Certificate Creation
```
This repo is used to create a certificate using Route53 DNS validation. It requires a hosted zone to which the IAM 
principal creating the resource has access.
```

### Example Usage:
```
# Variables definition

variable "acm_certificate_name" {
  description = "Certificate name prefix which will be trailed by the hosted-zone name"
  type = list(string)
}

variable "hosted_zone_name" {
  description = "Route53 hosted zone name"
  type        = string
}

acm_certificate_name  = ["engineering", "sales"]
hosted_zone_name      = "example.com"
```
```
data "aws_route53_zone" "hosted_zone_id" {
  name = var.hosted_zone_name
  private_zone = false
}
```
```
# Module call

module "new_record_and_certificate" {
  source = "github.com/StratusGrid/terraform-aws-acm-certificate-creation"
  
  for_each        = toset(var.acm_certificate_name)
  acm_domain_name = "${each.key}.${var.hosted_zone_name}"
  zone_id         = data.aws_route53_zone.hosted_zone_id.zone_id
  
  input_tags      = {
    "Name" = "${each.key}.${var.hosted_zone_name}"
    }
}
```