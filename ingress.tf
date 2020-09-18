module "alb_ingress_controller" {
  source  = "iplabs/alb-ingress-controller/kubernetes"
  version = "3.4.0"

  depends_on = [module.eks]

  providers = {
    kubernetes = kubernetes
  }

  k8s_cluster_type = "eks"
  k8s_namespace    = "kube-system"

  aws_region_name  = var.region
  k8s_cluster_name = data.aws_eks_cluster.cluster.name
}