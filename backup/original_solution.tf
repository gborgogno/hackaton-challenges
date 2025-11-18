
terraform {
  required_providers {
    docker = { # CORREÇÃO 1
      source  = "hashicorp/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {} # CORREÇÃO 2

resource "docker_image" "nginx_image" {
  name         = "nginx:latest"
  keep_local = true # CORREÇÃO 3: Valor booleano correto e nome do atributo
}

resource "docker_container" "nginx_hackathon" {
  image = docker_image.nginx_image.id

  name  = "nginx_hackaton" # CORREÇÃO 4: Nome do atributo é 'name'

  ports {
    internal = 80
    external = 8080 # CORREÇÃO 5: Definir a porta diretamente, sem output circular
  }
  
  restart = "always" # CORREÇÃO 6
}

output "container_port" {
  description = "A porta externa que o Nginx está rodando"
  value       = docker_container.nginx_hackathon.ports[0].external # CORREÇÃO 7: Correta indexação e uso de atributo 'external'
}

