variable "tag_contact" {
  type    = string
  default = "djfurman@gmail.com"
}

variable "tag_created_via" {
  type    = string
  default = "OpenTofu"
}

variable "tag_env" {
  type    = string
  default = "staging"
}

variable "tag_project" {
  type    = string
  default = "MyHealthCo"
}

variable "tag_purpose" {
  type    = string
  default = "o11y"
}

# CIDR Ranges
variable "lb_cidr_range" {
  type    = string
  default = "10.1.0.0/24"
}

variable "service_provider_cidr_range" {
  type    = string
  default = "10.100.0.0/19"
}

variable "service_endpoint_cidr_range" {
  type    = string
  default = "10.100.32.0/19"
}

variable "compute_cidr_range" {
  type    = string
  default = "10.2.0.0/22"
}

variable "inspection_cidr_range" {
  type    = string
  default = "10.1.1.0/26"
}

variable "public_cidr_range" {
  type    = string
  default = "10.1.1.64/26"
}
