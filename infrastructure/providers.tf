terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "sovereign-vpc-terraform-state"
    prefix = "foundation"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "github_org" {
  description = "GitHub organization name for OIDC configuration"
  type        = string
  default     = "Drecoder" # Set your default
}