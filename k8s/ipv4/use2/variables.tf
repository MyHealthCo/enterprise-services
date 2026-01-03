variable "cidr_primary" {
  description = "Primary CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/28"
}

variable "cidr_usable" {
  description = "Usable CIDR range for the VPC"
  type        = string
  default     = "10.2.8.0/23"
}

variable "cidr_service_endpoint" {
  description = "Service Endpoint CIDR range for the VPC"
  type        = string
  default     = "10.100.0.0/19"
}

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
  default = "k8s-ipv4"
}
