resource "aws_acm_certificate" "events" {
  for_each = var.site_mappings

  domain_name               = var.site_mappings[each.key].url
  subject_alternative_names = ["staging.${var.site_mappings[each.key].url}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  domain_validation_options = flatten([
    for site_key, site_value in var.site_mappings : [
      for dvo in aws_acm_certificate.events[site_key].domain_validation_options : {
        domain_name = dvo.domain_name
        site_mapping = site_key
        resource_record_name = dvo.resource_record_name
        resource_record_value = dvo.resource_record_value
        resource_record_type = dvo.resource_record_type
      }
    ]
  ])

  vanity_urls_sites = [
  for site_key, site_value in var.site_mappings : site_key if site_value.vanity_url != ""
  ]
}

resource "aws_route53_record" "event_acm_verification" {
   for_each = {
    for obj in local.domain_validation_options : obj.domain_name => {
      resource_record_name = obj.resource_record_name,
      resource_record_value = obj.resource_record_value,
      resource_record_type = obj.resource_record_type
      site_mapping = obj.site_mapping
   }
  }

  allow_overwrite = true
  name            = each.value.resource_record_name
  records         = [each.value.resource_record_value]
  ttl             = 300
  type            = each.value.resource_record_type
  zone_id         = var.site_mappings[each.value.site_mapping].vanity_url == each.key ? data.aws_route53_zone.vanity_hosted_zone[each.value.site_mapping].zone_id : data.aws_route53_zone.proxvirtual-com.zone_id
}