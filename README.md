# ACM Certificate Creation
This repo is used to create a certificate using DNS validation. It requires:
- That there be a hosted zone which the IAM principal creating the resource has access to

### Example Usage:
```
module "resource_certificate" {
  source     = "StratusGrid/acm-certificate-creation/aws"
  version    = "1.0.0"
  # source   = "github.com/StratusGrid/terraform-aws-acm-certificate-creation"
  acm_domain_name  = "host.my.domain.com"
  hosted_zone_name = "my.domain.com"
  input_tags = merge(local.common_tags, {})
}
```
