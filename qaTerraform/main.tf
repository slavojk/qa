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

resource "kubernetes_job" "qa" {
  metadata {
    name = var.appName
    namespace = var.ns
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name    = var.appName
          image   = var.image
        }
        restart_policy = "Never"
      }
    }
    backoff_limit = 4
  }
  wait_for_completion = true
  timeouts {
    create = "2m"
    update = "2m"
  }
}

