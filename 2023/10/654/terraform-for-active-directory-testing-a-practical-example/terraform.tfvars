# Network
vpc_cidr            = "10.11.0.0/16"
public_subnet_cidr  = "10.11.1.0/24"
private_subnet_cidr = "10.11.2.0/24"
# AWS Settings
aws_access_key = "my_aws_account"
aws_secret_key = "my_aws_account_secret_key"
aws_region     = "us-east-2"
# Windows Virtual Machine
# windows_instance_name               = "testsrv01"
windows_instance_type = "t3.large"
# windows_associate_public_ip_address = true
windows_root_volume_size    = 100
windows_root_volume_type    = "gp2"
windows_version             = "2019-English-Full-Base"
windows_domain_member_count = 3

# Application Settings
app_environment = "test"

# Active Directory Settings
windows_ad_domain_name   = "2019.adfs.cyral.local"
windows_ad_safe_password = "abc123...xyz789"
