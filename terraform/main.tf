variable "site_name" {
  description = "Domain name"
}

provider "aws" {
  region = "us-east-1"
}

module "website" {
  source = "./website"

  site_name = "${var.site_name}"
}