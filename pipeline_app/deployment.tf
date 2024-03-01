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
        }
      }
    }

    service_name = "pipeline-app"
  }
}
