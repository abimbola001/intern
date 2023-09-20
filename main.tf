terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "0.0.13"
    }

   kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "/root/.kube/config"
  }
}
provider "kind" {
  #name = "nodes-test"
}

provider "kubernetes" {
  config_path = "/root/.kube/config"
}

resource "kubectl_manifest" "nodejs" {
  yaml_body = file("${path.module}/deployment.yaml")
}

provider "kubectl" {
  config_path = "/root/.kube/config"  # Path to your kubeconfig file
}

module "kube" {
  source = "./modules/kube-prometheus"
  kube-version = "36.2.0"
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  #namespace  = "monitoring"
  version    = "36.2.0"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
}
