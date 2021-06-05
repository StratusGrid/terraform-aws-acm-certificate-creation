output "acm_certificate_arn" {
  description = "The ARN of the certificate created by this module"
  value       = aws_acm_certificate.acm_module_certificate.arn
}