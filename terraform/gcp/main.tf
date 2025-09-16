# WARNING: Commented out to prevent accidental charges.
# To use, remove comments, set credentials, and enable budget alerts.

# terraform {
#   required_version = ">= 1.6.0"
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "~> 5.0"
#     }
#   }
# }
# provider "google" {
#   project = var.project_id
#   region  = var.region
# }
# resource "google_storage_bucket" "demo" {
#   name          = var.bucket_name
#   location      = var.region
#   force_destroy = false
# }
# output "bucket_name" { value = var.bucket_name }
