resource "helm_release" "tekton" {
  depends_on = [module.alb_ingress_controller]

  name  = "tekton"
  chart = "${path.module}/helm/tekton"
}

provider "helm" {
  kubernetes {
    load_config_file       = "false"
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}