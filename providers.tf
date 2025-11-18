terraform {
  required_providers {
    docker = {
      source  = "hashicorp/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
