terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "qa" {
  metadata {
    name = var.ns
  }
}

resource "kubernetes_deployment" "qa" {
  metadata {
    name = var.appName
    namespace = var.ns
    labels = {
      App = var.appName
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = var.appName
      }
    }
    template {
      metadata {
        labels = {
          App = var.appName
        }
      }
      spec {
        container {
          image = var.image
          name  = var.appName

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

