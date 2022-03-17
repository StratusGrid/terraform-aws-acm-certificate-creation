variable "input_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "acm_certificate_name" {
  description = "Name of the certificate to be used in AWS ACM"
  type        = string
}

variable "zone_id" {
  description = "Route53 zone ID"
  type        = string
}