
resource "docker_image" "nginx_image" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx_hackathon" {
  name  = "nginx_hackaton"
  image = docker_image.nginx_image.name

  ports {
    internal = 80
    external = var.container_port
  }

  restart = "always"
}
