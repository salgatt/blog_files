variable "digital_ocean_registry" {
  type = string
}

data "kubernetes_namespace" "application_pipeline" {
  metadata {
    name = "application-pipeline"
  }
}

resource "kubernetes_stateful_set" "example" {
  metadata {
    name      = "pipeline-app-statefulset"
    namespace = data.kubernetes_namespace.application_pipeline.metadata[0].name
    labels = {
      app = "pipeline-app"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "pipeline-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "pipeline-app"
        }
      }

      spec {
        security_context {
          run_as_user = 1000
          fs_group    = 1000
        }

        container {
          image = "registry.digitalocean.com/${var.digital_ocean_registry}/pipeline_app"
          name  = "pipeline-app"

          port {
            container_port = 8000
          }

          liveness_probe {
            http_get {
              path = "/status"
              port = "8000"
            }

            initial_delay_seconds = 60
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/status"
              port = "8000"
            }

            initial_delay_seconds = 30
            period_seconds        = 5
          }
          security_context {
            run_as_non_root = true
            run_as_user     = 1001
            capabilities {
              add  = ["NET_BIND_SERVICE"]
              drop = ["ALL"]
            }
          }
        }
      }
    }

    service_name = "pipeline-app"
  }
}
