variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "project" {
  type    = string
  default = "devops-practice"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Use t2.micro in regions where t3.micro is not free-tier eligible."
}

variable "key_name" {
  type        = string
  description = "Name of an EXISTING EC2 key pair (create it in the AWS console first)."
}

variable "my_ip_cidr" {
  type        = string
  description = "Your public IP in CIDR form, e.g. 203.0.113.10/32 (search 'what is my ip')."
}

variable "alert_email" {
  type        = string
  default     = ""
  description = "Optional email address for CloudWatch alarm notifications."
}
