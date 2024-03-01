output "password_decrypted" {
  value     = rsadecrypt(aws_instance.windows-server-dc.password_data, tls_private_key.key_pair.private_key_pem)
  sensitive = true
}
