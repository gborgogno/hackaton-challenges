# 🛠️ Desafio de Debug: Infraestrutura como Código Quebrada (Terraform + Docker)

## 🚨 O Desafio

Seja bem-vindo ao desafio "Debug de IaC"!

Seu objetivo não é escrever infraestrutura, mas sim **consertá-la**. Você recebeu um arquivo `main.tf` que tenta provisionar um contêiner Docker Nginx simples, mas ele foi sabotado com vários erros de sintaxe, lógica e configuração.

O Terraform é conhecido por ser rigoroso. A missão da sua equipe é identificar e corrigir **todos** os problemas para que a infraestrutura seja provisionada com sucesso.

## Pré-requisitos

1.  **Terraform:** Instalado e configurado.
2.  **Docker:** Instalado e rodando (para que o provedor Docker funcione).

## 🚀 Passos para a Solução

1.  **Clonar o Repositório:** Faça um clone deste repositório.
2.  **Diagnóstico:** Execute os comandos básicos do Terraform para tentar identificar os problemas.
    * `terraform init`
    * `terraform validate` (Este comando será seu melhor amigo!)
    * `terraform plan`
3.  **Correção:** Edite o arquivo `main.tf`, corrigindo os erros.
4.  **Verificação Final:** Quando o `terraform plan` não retornar erros e mostrar a adição dos dois recursos (imagem e contêiner), execute o comando final:
    * `terraform apply -auto-approve`

## ✅ Critério de Sucesso

O desafio será considerado **completo** quando:

1.  O comando `terraform apply` for executado com sucesso.
2.  Um contêiner chamado `nginx_hackaton` estiver rodando no seu ambiente Docker.
3.  O Nginx for acessível no seu navegador via `http://localhost:[PORTA_CORRETA]`.
4.  O comando `terraform destroy` remover todos os recursos sem erro.

---
# 🐛 O Código Quebrado (main.tf)

## COPIE E COLE ESTE CÓDIGO NO main.tf PARA COMEÇAR A DEPURAÇÃO!

```terraform
terrafom {
  required_providers {
    # Erro 1: Nome do provedor na source
    docker-provider = {
      source = "hashicorp/docker"
      version = "~> 3.0"
    }
  }
}

# Erro 2: Bloco provider mal definido
prowider "docker" {}

# Recurso 1: Puxar Imagem Docker
resource "docker_image" "nginx_image" {
  name         = "nginx:latest"
  keep_local = false # Erro 3: Typo no atributo
}

# Recurso 2: Criar Contêiner Docker
resource "docker_container" "nginx_hackathon" {
  image = docker_image.nginx_image.id

  # Erro 4: Typo no nome do recurso (deveria ser "nginx_hackathon")
  nome  = "nginx_hackaton" 
  
  ports {
    internal = 80
    
    # Erro 5: Variável de output usada como atributo de porta
    external = output.container_port.value 
  }
  
  # Erro 6: Bloco restart_policy é inexistente, deveria ser restart
  restart_policy "always" 
}

# Recurso 3: Output (Saída de dados)
output "container_port" {
  description = "A porta externa que o Nginx está rodando"
  
  # Erro 7: Referência incorreta ao recurso e atributo
  value       = docker_container.nginx_hackaton.ports.0.public_port
}