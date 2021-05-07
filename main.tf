# Certificate creation
resource "aws_acm_certificate" "acm_module_certificate" {
  domain_name       = var.acm_domain_name
  validation_method = "DNS"

  tags = local.local_tags

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
  }
}

# Route53 record creation
resource "aws_route53_record" "domain_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_module_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

# Certificate validation
resource "aws_acm_certificate_validation" "acm_module_cert_validation" {
  certificate_arn         = aws_acm_certificate.acm_module_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_validation_record : record.fqdn]
}