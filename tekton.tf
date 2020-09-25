resource "helm_release" "tekton" {
  depends_on = [module.alb_ingress_controller]

  name  = "tekton"
  chart = "./helm/tekton"
}