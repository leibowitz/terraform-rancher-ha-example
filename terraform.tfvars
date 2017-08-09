# AWS key for the instances
key_name = "rancher-ha-example"


db_name = "rancherhaexample"
# RDS database password
db_pass = "rancherdbpass"

region = "eu-west-1"

# https://github.com/rancher/os/blob/master/README.md#amazon
# for future, ecs enable amis
# http://rancher.com/docs/os/amazon-ecs/#amazon-ecs-enabled-amis

count = "1"

# https://aws.amazon.com/ec2/instance-types/
instance_type = "t2.small"

availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
subnet_cidrs = ["192.168.199.0/26", "192.168.199.64/26", "192.168.199.128/26"]

# To enable SSL termination on the ELBs, uncomment the lines below.
enable_https = true
#cert_body = "${acme_certificate.certificate.certificate_pem}"
#cert_chain = "${acme_certificate.certificate.issuer_pem}"
#cert_private_key = "${acme_certificate.certificate.private_key_pem}"
# cert_body = "certs/cert1.pem"              # Signed Certificate
# cert_private_key = "certs/privkey1.pem"    # Certificate Private Key
# cert_chain = "certs/chain1.pem"            # CA chain
