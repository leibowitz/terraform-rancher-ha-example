# AWS key for the instances
key_name = "rancher-ha-example"


db_name = "rancherhaexample"
# RDS database password
db_pass = "rancherdbpass"

region = "eu-west-1"

# https://github.com/rancher/os/blob/master/README.md#amazon
ami = "ami-64b2a802"

count = "1"

instance_type = "t2.nano"

availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
subnet_cidrs = ["192.168.199.0/26", "192.168.199.64/26", "192.168.199.128/26"]

# To enable SSL termination on the ELBs, uncomment the lines below.
# enable_https = true
# cert_body = "certs/cert1.pem"              # Signed Certificate
# cert_private_key = "certs/privkey1.pem"    # Certificate Private Key
# cert_chain = "certs/chain1.pem"            # CA chain
