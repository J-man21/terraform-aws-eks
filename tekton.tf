resource "helm_release" "tekton" {
  name  = "tekton"
  chart = "${path.module}/helm/tekton"
}