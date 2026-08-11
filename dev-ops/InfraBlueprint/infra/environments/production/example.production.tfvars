vela_region = "us-east-1"

vela_main_vpc_cidr = "10.1.0.0/16"

vela_public_subnet_cidrs = [
  "10.1.1.0/24",
  "10.1.2.0/24"
]

vela_private_subnet_cidrs = [
  "10.1.101.0/24",
  "10.1.102.0/24"
]

azs = [
  "us-east-1a",
  "us-east-1b"
]

vela_admin_ip_cidr = "203.0.113.5/32"

vela_instance_type = "t2.micro"

vela_s3_bucket_name = "vela-payments-s3-production-example"

vela_db_username = "REPLACE_ME"

vela_db_password = "REPLACE_ME"

vela_skip_final_snapshot = false