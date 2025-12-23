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
  default = "connectivity"
}
