module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "graylog-k8s-vpc"
  cidr = "10.0.0.0/16"

  azs                  = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/graylog-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/graylog-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/graylog-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}
