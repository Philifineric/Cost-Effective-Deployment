
# Output the generated SSH private key (PEM format) for connecting to the EC2 instance.
# Note: If you generated a key locally, use that instead for better security.
output "ssh_private_key_pem" {
	value       = tls_private_key.k3s_key.private_key_pem
	description = "(If you generated a key locally, use that instead.)"
}