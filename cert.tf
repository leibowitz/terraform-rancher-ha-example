# Create the private key for the registration (not the certificate)
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

# Set up a registration using a private key from tls_private_key
resource "acme_registration" "reg" {
  server_url      = "${var.cert_server_url}"
  account_key_pem = "${tls_private_key.private_key.private_key_pem}"
  email_address   = "${var.cert_email_address}"
}

# Create a certificate
resource "acme_certificate" "certificate" {
  server_url       = "${var.cert_server_url}"
  account_key_pem  = "${tls_private_key.private_key.private_key_pem}"
  common_name      = "${var.record_name}"

  dns_challenge {
    provider = "route53"
  }

  registration_url = "${acme_registration.reg.id}"
}
