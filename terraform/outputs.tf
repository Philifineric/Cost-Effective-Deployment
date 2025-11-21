output "ssh_private_key_pem" {
value = tls_private_key.k3s_key.private_key_pem
description = "(If you generated a key locally, use that instead.)"
}