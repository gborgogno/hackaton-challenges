---
title: Desafio Debug IaC (Terraform + Docker)
---

# Desafio: Debug IaC — Terraform + Docker

Este site contém instruções para executar o desafio localmente e em um workspace (GitHub Codespaces / Dev Container).

## Objetivo

Consertar o `main.tf` quebrado para que um container Nginx (`nginx_hackaton`) seja criado e acessível em `http://localhost:8080`.

## Como executar localmente

- Instale e configure o `terraform` e o `docker` localmente.
- No diretório do desafio:

```bash
cd hackaton-challenges
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

Depois, acesse `http://localhost:8080`.

Para destruir os recursos:

```bash
terraform destroy -auto-approve
```

## Executando no GitHub Codespaces / Dev Container (recomendado)

1. Abra este repositório no GitHub e clique em **Code → Codespaces → New codespace**.
2. O devcontainer provisiona um ambiente com `terraform` e `docker` CLI instalados.
3. No terminal do Codespace:

```bash
cd hackaton-challenges
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

Observação: o container do Codespace pode não expor o daemon Docker do host por padrão. Se necessário, utilize a opção de habilitar o Docker socket no Codespace ou execute o desafio localmente.

## Página do desafio

Quando o workflow de GitHub Actions rodar com sucesso, esta página será publicada via GitHub Pages.
