variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-1"
}

# EC2 Variables

variable "ami" {
  description = "Amazon machine image to use for ec2 instance"
  type        = string
  default     = "ami-xxxxxxxxxxxxxx" # Ubuntu 20.04 LTS // us-east-1
}

variable "key_name" {
  description = "ec2 instance key pair name to use"
  type        = string
  default     = "keypair-name"
}

# Route53 Domain variables

variable "jenkins_instance_type" {
  description = "ec2 instance type for the jenkins server"
  type        = string
  default     = "t2.large"
}

variable "kube_instance_type" {
  description = "ec2 instance type for the kubernetes cluster nodes"
  type        = string
  default     = "t2.medium"
}

variable "monitoring_instance_type" {
  description = "ec2 instance type for the monitoring server"
  type        = string
  default     = "t2.medium"
}

variable "domain" {
  description = "Zweek Domain"
  type        = string
  default     = "example.com"
}

# VPC variables

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "instance_profile_name" {
  type    = string
  default = "master_profile"
}

variable "iam_policy_name" {
  type    = string
  default = "velero_access-resources"
}

variable "role_name" {
  type    = string
  default = "veleroS3Access"
}
