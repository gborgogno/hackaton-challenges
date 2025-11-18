provider "docker" {
  host = "unix:///var/run/dockers.sock" # intentional typo for the challenge
}

resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_hackathon" {
  nome  = "nginx_hackaton"

  image = docker_image.nginx_image.id

  ports {
    internal = 80
    external = output.container_port.value
  }

  restart_policy = "always"
}
