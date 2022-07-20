<!-- BEGIN_TF_DOCS -->
# terraform-aws-acm-certificate-creation

GitHub: [StratusGrid/terraform-aws-terraform-aws-acm-certificate-creation](https://github.com/StratusGrid/terraform-aws-acm-certificate-creation)

This module is used to create a certificate using Route53 DNS validation. It requires a hosted zone to which the IAM
principal creating the resource has access.

## Examples

```hcl
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

# Data resource retrieving the provided hosted-zone's ID
data "aws_route53_zone" "hosted_zone_id" {
  name = var.hosted_zone_name
  private_zone = false
}

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
---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | <= 4.9 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.acm_module_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.acm_module_cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.domain_validation_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_domain_name"></a> [acm\_domain\_name](#input\_acm\_domain\_name) | Name of the certificate to be created in AWS ACM / FQDN | `string` | n/a | yes |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 zone ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | The ARN of the certificate created by this module |

---

Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml`
<!-- END_TF_DOCS -->