region       = "ap-south-1"
env          = "dev"
project_name = "nova-project"

cidr = "10.0.0.0/16"

public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
azs            = ["ap-south-1a", "ap-south-1b"]

image = "nginx:latest"

# domain  = "example.com"
# zone_id = "ZXXXXXXXXXXX"