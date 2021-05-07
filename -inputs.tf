variable "account_numbers" {
  default         = []
  description     = "Allowed AWS account ids"
  type            = list(string)
}

variable "env_name" {
  #Used in locals.tf
  default         = ""
  description     = "Environment name string to be used for decisions and name generation (prd, stg, dev)"
  type            = string
}

variable "region" {
  default         = ""
  description     = "AWS Region"
  type            = string
}

variable "access_key" {
  default         = ""
  description     = "IAM Account Access Key"
  type            = string
}

variable "secret_key" {
  default         = ""
  description     = "IAM Account Secret Key"
  type            = string
}

variable "token" {
  default         = ""
  description     = "IAM Account MFA Token retrieved with sts get-session-token"
  type            = string
}

variable "aws_profile" {
  default         = ""
  description     = "AWS CLI Profile Name"
  type            = string
}

variable "override_name_suffix" {
  #Used in locals.tf
  default         = ""
  description     = "Value to override name_suffix with."
  type            = string
}
variable "append_name_suffix" {
  #Used in locals.tf
  default         = ""
  description     = "Value to append to name_suffix"
  type            = string
}

variable "prepend_name_suffix" {
  #Used in locals.tf
  default         = ""
  description     = "Value to prepend to name_suffix"
  type            = string
}

variable "source_repo" {
  default         = ""
  description     = "URL of repo which holds this code"
  type            = string
}

variable "name_prefix" {
  default         = ""
  description     = "String to use as prefix on object names"
  type            = string
}

variable "name_suffix" {
  description = "String to append to object names. This is optional, so start with dash if using."
  type        = string
  default     = ""
}

variable "input_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "acm_domain_name" {
  description = "Name of the certificate to be used in AWS ACM"
  type        = string
}

variable "zone_id" {
  description = "Route53 zone ID"
  type        = string
}

variable "r53_domain_name" {
  description = "Route53 domain name"
  type        = string
}