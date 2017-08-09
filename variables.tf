#------------------------------------------#
# AWS Environment Variables
#------------------------------------------#
variable "region" {
    default     = "us-east-1"
    description = "The region of AWS, for AMI lookups"
}

variable "count" {
    default     = "3"
    description = "Number of HA servers to deploy"
}

variable "zone_id" {
    default     = ""
    description = "Hosted Zone ID for adding the rancher host"
}

variable "record_name" {
    default     = ""
    description = "FQDN to access rancher UI"
}

# https://github.com/paybyphone/terraform-provider-acme
variable "cert_email_address" {
    default     = ""
    description = "The email address that will be attached as a contact to the registration"
}

# Use https://acme-v01.api.letsencrypt.org/directory for production
variable "cert_server_url" {
    default     = "https://acme-staging.api.letsencrypt.org/directory"
    description = "The URL of the ACME directory endpoint"
}

variable "name_prefix" {
    default     = "rancher-ha"
    description = "Prefix for all AWS resource names"
}

variable "amis" {
    # https://github.com/rancher/os/blob/master/README.md#amazon
    default     = {
            "eu-west-1" = "ami-64b2a802"
            "eu-west-2" = "ami-4806102c"
            "ap-south-1" = "ami-3576085a"
            "ap-northeast-1" = "ami-8bb1a7ec"
            "ap-northeast-2" = "ami-9d03dcf3"
            "sa-east-1" = "ami-ae1b71c2"
            "ca-central-1" = "ami-4fa7182b"
            "ap-southeast-1" = "ami-4f921c2c"
            "ap-southeast-2" = "ami-d64c5fb5"
            "eu-central-1" = "ami-8c52f4e3"
            "us-east-1" = "ami-067c4a10"
            "us-east-2" = "ami-b74b6ad2"
            "us-west-1" = "ami-04351964"
            "us-west-2" = "ami-bed0c7c7"
    }
    description = "Instance AMI ID"
}

variable "key_name" {
    description = "SSH key name in your AWS account for AWS instances"
}

variable "instance_type" {
    default     = "t2.large" # RAM Requirements >= 8gb
    description = "AWS Instance type"
}

variable "root_volume_size" {
    default     = "16"
    description = "Size in GB of the root volume for instances"
}

variable "vpc_cidr" {
    default     = "192.168.199.0/24"
    description = "Subnet in CIDR format to assign to VPC"
}

variable "subnet_cidrs" {
    default     = ["192.168.199.0/26", "192.168.199.64/26", "192.168.199.128/26"]
    description = "Subnet ranges (requires 3 entries)"
}

variable "availability_zones" {
    default     = ["us-east-1a", "us-east-1b", "us-east-1d"]
    description = "Availability zones to place subnets"
}

variable "internal_elb" {
    default     = "false"
    description = "Force the ELB to be internal only"
}

#------------------------------------------#
# Database Variables
#------------------------------------------#
variable "db_name" {
    default     = "rancher"
    description = "Name of the RDS DB"
}

variable "db_user" {
    default     = "rancher"
    description = "Username used to connect to the RDS database"
}

variable "db_pass" {
    description = "Password used to connect to the RDS database"
}

#------------------------------------------#
# SSL Variables
#------------------------------------------#
variable "enable_https" {
    default     = false
    description = "Enable HTTPS termination on the loadbalancer"
}

#------------------------------------------#
# Rancher Variables
#------------------------------------------#
variable "rancher_version" {
    default     = "stable"
    description = "Rancher version to deploy"
}
