# AWS key for the instances
key_name = "rancher-ha-example"


db_name = "rancherhaexample"
# RDS database password
db_pass = "rancherdbpass"

region = "eu-west-1"

ami = "ami-64b2a802"

count = "1"

instance_type = "t2.medium"

availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

# To enable SSL termination on the ELBs, uncomment the lines below.
# enable_https = true
# cert_body = "certs/cert1.pem"              # Signed Certificate
# cert_private_key = "certs/privkey1.pem"    # Certificate Private Key
# cert_chain = "certs/chain1.pem"            # CA chain
