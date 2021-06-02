variable "input_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "site_mappings" {
  default = {}
  description = "Map of static websites to be created and distributed through CloudFront."
  type = map(object(
    {
      url                   = string
      vanity_url            = string
      vanity_hosted_zone    = string
    }
  ))
}