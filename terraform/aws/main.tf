# WARNING: Commented out to prevent accidental charges.
# To use, remove comments, set credentials, and enable budget alerts.

# terraform {
#   required_version = ">= 1.6.0"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }
# provider "aws" {
#   region = var.region
# }
# resource "aws_s3_bucket" "demo" {
#   bucket = var.bucket_name
#   force_destroy = false
#   tags = { Project = "cloud-portfolio-starter" }
# }
# output "bucket_name" { value = var.bucket_name }
