module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "graylog-eks-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    instance_types = ["t2.micro", "t2.small", "t3.micro", "t3.small", "t3a.small"]
  }

  eks_managed_node_groups = {
    blue  = {}
    green = {
      min_size     = 1
      max_size     = 12
      desired_size = 10

      instance_types = ["t2.small", "t3.small", "t3a.small"]
      capacity_type  = "SPOT"
    }
  }
}


output "cluster_aws_auth_configmap" {
  description = "AWS auth configmap for the EKS cluster"
  value       = module.eks.aws_auth_configmap_yaml
}

output "cluster_endpoint" {
  description = "Endpoint for control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster."
  value       = module.eks.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "IAM role associated with the EKS cluster."
  value       = module.eks.cluster_iam_role_name
}

output "cluster_certificate_authority_data" {
  description = "Certificate authority data for the cluster"
  value       = module.eks.cluster_certificate_authority_data
}
