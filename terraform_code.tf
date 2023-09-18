terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "0.0.13"
    }
  }
}


provider "kind" {
  #name = "nodes-test"
}

provider "kubernetes" {
  config_path = "/root/.kube/config"
}
provider "helm" {
  kubernetes {
    config_path = "<your_kubeconfig_path>"
  }
}

resource "kubernetes_secret" "docker-registry" {
  metadata {
    name = "dockerhubpull"
  }
}
resource "kubernetes_deployment" "Nodeappdeployment" {
  metadata {
    name = "nodeapp1"
    #namespace = "hello_world"
    labels = {
      app = "nodejs"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "nodejs"
      }
    }
    template {
      metadata {
        labels = {
          app = "nodejs"
        }
      }
      spec {
        container {
          image = "aokusada/hello1-express"
          name  = "hello-express"


        }
      }
    }
  }

resource "kubernetes_service" "hello_world1_service" {
  depends_on = [kubernetes_deployment.Nodeappdeployment]

  metadata {
    labels = {
      app = "hello-world-example1"
    }
    name = "hello-world-example1"
    #namespace = kubernetes_namespace.hello_world_namespace.metadata.0.name
  }

  spec {
    port {
      name = "api1"
      port = 8080
      target_port = 8080
    }
    selector = {
      app = "hello-world-example1"
    }
    type = "NodePort"
  }
}

