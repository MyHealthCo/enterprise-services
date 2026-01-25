variable "cidr_primary" {
  description = "Primary CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/28"
}

variable "cidr_usable" {
  description = "Usable CIDR range for the VPC"
  type        = string
  default     = "10.2.4.0/23"
}

variable "core_network_arn" {
  description = "Core Network ARN"
  type        = string
  default     = ""
}

variable "core_network_id" {
  description = "Core Network ID"
  type        = string
  default     = ""
}

variable "tag_contact" {
  description = "Contact email for all resources created in this module"
  type        = string
  default     = "djfurman@gmail.com"
}

variable "tag_created_via" {
  description = "Tag to indicate the tool used to create resources"
  type        = string
  default     = "OpenTofu"
}

variable "tag_env" {
  description = "Tag to indicate the environment for which all of the resources were created"
  type        = string
  default     = "staging"
}

variable "tag_project" {
  description = "Tag to indicate the project for which all of the resources were created"
  type        = string
  default     = "MyHealthCo"
}

variable "tag_purpose" {
  description = "Tag to indicate the purpose or test case for which all of the resources were created"
  type        = string
  default     = "connectivity"
}
