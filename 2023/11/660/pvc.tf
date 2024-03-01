resource "kubernetes_persistent_volume_claim" "postgres-pv" {
  metadata {
    name      = "postgres-db-pv"
    namespace = kubernetes_namespace.pipeline.metadata[0].name
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "do-block-storage"
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}
