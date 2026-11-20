data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = sort(tolist(data.aws_availability_zones.available.names))

  public_subnets = [
    for i in range(length(local.azs)) :
    cidrsubnet("10.0.0.0/16", 8, i + 4)
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "trainee-vpc"
  cidr = "10.0.0.0/16"

  azs            = local.azs
  public_subnets = local.public_subnets

  map_public_ip_on_launch = true
}