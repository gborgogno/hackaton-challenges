# 🛠️ Desafio de Debug: Infraestrutura como Código  (Terraform + Docker)

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

## 🚀 Executando no GitHub Codespaces (recomendado)

Este repositório inclui uma configuração de Dev Container que instala o `terraform` e prepara um ambiente com Docker-in-Docker para que você possa provisionar o desafio diretamente no Codespace.

Passos:

1. No GitHub, abra este repositório e clique em **Code → Codespaces → New codespace**.
2. Aguarde a criação do Codespace. O devcontainer usará as features `docker-in-docker` e `terraform`.
3. Quando o Codespace estiver pronto, abra o terminal integrado e execute (ou aguarde o `postCreateCommand` que já dispara):

```bash
cd hackaton-challenges
./provision.sh
```

O script `provision.sh` executa `terraform init`, `terraform validate`, `terraform plan` e tenta aplicar o plano. Se preferir, rode os comandos Terraform manualmente.

Observações importantes:

- O Dev Container foi configurado com `runArgs: ["--privileged"]` para permitir o funcionamento do Docker-in-Docker. Se o seu ambiente Codespaces/organizacao não permitir contêineres privilegiados, a criação de containers poderá falhar — nesse caso execute os passos localmente em uma máquina com Docker instalado ou forneça um `PERSONAL_TOKEN` para o workflow de Pages.
- Se precisar apenas da página da tarefa (GitHub Pages), veja `hackaton-challenges/docs/index.md`.

## ✅ Critério de Sucesso

O desafio será considerado **completo** quando:

1.  O comando `terraform apply` for executado com sucesso.
2.  Um contêiner chamado `nginx_hackaton` estiver rodando no seu ambiente Docker.
3.  O Nginx for acessível no seu navegador via `http://localhost:[PORTA_CORRETA]`.
4.  O comando `terraform destroy` remover todos os recursos sem erro.
