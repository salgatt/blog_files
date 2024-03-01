# Bootstrapping PowerShell Script
data "template_file" "windows-member-userdata" {
  template = <<EOF
<powershell>

Set-ExecutionPolicy unrestricted -Force

net user Administrator "${var.windows_ad_safe_password}"
$domain = (Get-WmiObject win32_computersystem).Domain
$hostname = hostname
$domain_username = "${var.windows_ad_domain_name}\${var.windows_ad_user_name}"
$domain_password = ConvertTo-SecureString "${var.windows_ad_safe_password}" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($domain_username,$domain_password)

if ($domain -ne '${var.windows_ad_domain_name}'){
  Start-Sleep -Seconds 600
  Add-Computer -DomainName ${var.windows_ad_domain_name} -Credential $credential -Passthru -Verbose -Force -Restart
}

Start-Sleep -Seconds 5
</powershell>
<persist>true</persist>
EOF
}

# Create EC2 Instance
resource "aws_instance" "windows-server-member" {
  count                  = var.windows_domain_member_count
  ami                    = data.aws_ami.windows-server.id
  instance_type          = var.windows_instance_type
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.aws-windows-sg.id]
  source_dest_check      = false
  key_name               = aws_key_pair.key_pair.key_name
  user_data              = data.template_file.windows-member-userdata.rendered
  monitoring             = true

  # root disk
  root_block_device {
    volume_size           = var.windows_root_volume_size
    volume_type           = var.windows_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "windows-server-member"
    Environment = var.app_environment
  }
}

#resource "aws_network_interface" "windows-server-member-private" {
#  subnet_id       = aws_subnet.private-subnet.id
#  attachment {
#    device_index = 1
#    instance   = "${element(aws_instance.windows-server-member.*.id,count.index)}"
#  }
#  private_ips_count = 2
#  security_groups = [ aws_security_group.aws-windows-private-sg.id ]
#  count = "${var.windows_domain_member_count}"
#}
