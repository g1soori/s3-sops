provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
  # version    = "~> 3.0"
}

variable access_key {
  type        = string
  default     = ""
  description = "description"
}

variable secret_key {
  type        = string
  default     = ""
  description = "description"
}

