module "postgresql" {
  source        = "ballj/postgresql/kubernetes"
  version       = "~> 1.2"
  namespace     = kubernetes_namespace.pipeline.metadata[0].name
  object_prefix = "k8-pg"
  name          = "k8-pg-db"
  pvc_name      = kubernetes_persistent_volume_claim.postgres-pv.metadata[0].name
  image_tag     = "16.0.0"
  env_secret = [
    {
      name   = "POSTGRES_POSTGRES_PASSWORD"
      secret = "postgres-credentials"
      key    = "postgres-password"
    },
    {
      name   = "POSTGRES_PASSWORD"
      secret = "postgres-credentials"
      key    = "password"
    }
  ]
}
