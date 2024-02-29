resource "kubernetes_deployment" "pipeline_app_ubuntu" {
  wait_for_rollout = null
  metadata {
    annotations   = {}
    generate_name = null
    labels = {
      apps = "ubuntu"
    }
    name      = "ubuntu"
    namespace = "application-pipeline"
  }
  spec {
    min_ready_seconds         = 0
    paused                    = false
    progress_deadline_seconds = 600
    replicas                  = "1"
    revision_history_limit    = 10
    selector {
      match_labels = {
        app = "ubuntu"
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
    template {
      metadata {
        annotations   = {}
        generate_name = null
        labels = {
          app = "ubuntu"
        }
        name      = null
        namespace = "application-pipeline"
      }
      spec {
        automount_service_account_token  = false
        dns_policy                       = "ClusterFirst"
        enable_service_links             = false
        host_ipc                         = false
        host_network                     = false
        host_pid                         = false
        hostname                         = null
        node_name                        = null
        node_selector                    = {}
        priority_class_name              = null
        restart_policy                   = "Always"
        runtime_class_name               = null
        scheduler_name                   = "default-scheduler"
        service_account_name             = null
        share_process_namespace          = false
        subdomain                        = null
        termination_grace_period_seconds = 30
        container {
          args                       = []
          command                    = ["/bin/sleep", "3651d"]
          image                      = "registry.digitalocean.com/k8-registry/ubuntu-client:latest"
          image_pull_policy          = "Always"
          name                       = "ubuntu"
          stdin                      = false
          stdin_once                 = false
          termination_message_path   = "/dev/termination-log"
          termination_message_policy = "File"
          tty                        = false
          working_dir                = null
          env {
            name  = "MY_SERVICE_NAME"
            value = null
            value_from {
              field_ref {
                api_version = "v1"
                field_path  = "spec.serviceAccountName"
              }
            }
          }
          resources {
            limits   = {}
            requests = {}
          }
        }
      }
    }
  }
  timeouts {
    create = null
    delete = null
    update = null
  }
}
