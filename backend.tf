# Terraform docs re: configuring back end: https://www.terraform.io/docs/backends/types/gcs.html
terraform {
  backend "gcs" {
    prefix  = "terraform/state"
    bucket = "gcpidentityexample-1-cf-1-terraform"
  }
}
