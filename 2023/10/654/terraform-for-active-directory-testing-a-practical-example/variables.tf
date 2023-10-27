# Application Environment Tag
# This is used to tag the EC2 instances with an environment tag
variable "app_environment" {
  type        = string
  description = "This is used to add an environment tag to EC2 instances"
}

# AWS Availability Zone
variable "aws_az" {
  type        = string
  description = "Use this to specify the availability zone for the subnets and EC2 instances"
  default     = "us-east-2c"
}

# VPC Variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
  default     = "10.1.64.0/18"
}

# Subnet Variables
variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for the public subnet"
  default     = "10.1.64.0/24"
}

# Subnet Variables
variable "private_subnet_cidr" {
  type        = string
  description = "CIDR for the public subnet"
  default     = "10.1.65.0/24"
}

# AWS Credentials
variable "aws_access_key" {
  type = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}

variable "aws_region" {
  type = string
  description = "AWS region"
}

# Windows Specific Variables
# 
# Supported Values:
# - 2012-R2_RTM-English-64Bit-Base
# - 2016-English-Full-Base
# - 2019-English-Full-Base
# - 2022-English-Full-Base
variable "windows_version" {
  type        = string
  description = "EC2 Windows Server Version"
  default     = "2019-English-Full-Base"
}

variable "windows_instance_type" {
  type        = string
  description = "EC2 instance type for Windows Server"
  default     = "t2.micro"
}

variable "windows_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}

variable "windows_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Windows Server"
  default     = "30"
}

variable "windows_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Windows Server."
  default     = "gp2"
}

variable "windows_instance_name" {
  type        = string
  description = "EC2 instance name for Windows Server"
  default     = "tfwinsrv01"
}

variable "windows_ad_domain_name" {
  type = string
  description = "Active Directory Domain Name"
  default = "2019.adfs.cyral.local"
}

variable "windows_ad_nebios_name" {
  type = string
  description = "Active Directory NetBIOS Name"
  default = "ADFS"
}

variable "windows_ad_safe_password" {
  type = string
  description = "Active Directory DSRM Password"
}

variable "windows_ad_user_name" {
  type = string
  description = "Username used for the local Administrator"
  default = "Administrator"
}

variable "windows_domain_member_count" {
  type = number
  description = "Number of domain members to add to this domain"
  default = "2"
}
