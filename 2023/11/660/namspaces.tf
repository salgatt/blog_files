resource "kubernetes_namespace" "pipeline" {
  metadata {
    name = "database-pipeline"
  }
}
