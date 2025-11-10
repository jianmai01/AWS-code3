# Generate new key pair locally
resource "tls_private_key" "windows_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${replace(var.customer_name, " ", "_")}${"_Key_Pair"}"
  public_key = tls_private_key.windows_key.public_key_openssh
}


# Save the private key locally
resource "local_file" "private_key_pem" {
  filename = "${replace(var.customer_name, " ", "_")}${"_Key_Pair.pem"}"
  content  = tls_private_key.windows_key.private_key_pem
  file_permission = "0600"
}
