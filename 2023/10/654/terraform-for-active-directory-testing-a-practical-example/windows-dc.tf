# Bootstrapping PowerShell Script
data "template_file" "windows-dc-userdata" {
  template = <<EOF
<powershell>
net user Administrator "${var.windows_ad_safe_password}"
$Password = ConvertTo-SecureString "${var.windows_ad_safe_password}" -AsPlainText -Force;
Add-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath C:\Windows\NTDS -DomainMode WinThreshold -DomainName ${var.windows_ad_domain_name} -DomainNetbiosName ${var.windows_ad_nebios_name} -ForestMode WinThreshold -InstallDns:$true -LogPath C:\Windows\NTDS -NoRebootOnCompletion:$true -SafeModeAdministratorPassword $Password -SysvolPath C:\Windows\SYSVOL -Force:$true;

Restart-Computer;

</powershell>
EOF
}

# Create EC2 Instance
resource "aws_instance" "windows-server-dc" {
  ami                    = data.aws_ami.windows-server.id
  instance_type          = var.windows_instance_type
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.aws-windows-sg.id]
  source_dest_check      = false
  key_name               = aws_key_pair.key_pair.key_name
  user_data              = data.template_file.windows-dc-userdata.rendered
  get_password_data      = true
  monitoring             = true

  # root disk
  root_block_device {
    volume_size           = var.windows_root_volume_size
    volume_type           = var.windows_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "windows-server-dc"
    Environment = var.app_environment
  }
}
