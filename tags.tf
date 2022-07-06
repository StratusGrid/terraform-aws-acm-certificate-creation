locals {
  local_tags = merge(var.input_tags, {
    "ModuleSourceRepo" = "github.com/StratusGrid/terraform-aws-acm-certificate-creation"
  })
}