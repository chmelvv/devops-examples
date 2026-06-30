module "eks" {
  source  = "terraform-aws-modules/eks/aws"
 version = "~> 20.37.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = true
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "PRESERVE"
    }
  }

  eks_managed_node_groups = {
    default_node_group = {
      instance_types = ["t3.small"]
      min_size       = 3
      max_size       = 3
      desired_size   = 3

      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }
}