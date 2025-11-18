# 🛠️ Desafio de Debug: Infraestrutura como Código (Terraform + Docker)

## 🚨 O Desafio

Seja bem-vindo ao desafio "Debug de IaC"!

Seu objetivo não é escrever infraestrutura, mas sim **consertá-la**. Você recebeu um arquivo `main.tf` que tenta provisionar um contêiner Docker Nginx simples, mas ele foi sabotado com vários erros de sintaxe, lógica e configuração.

O Terraform é rigoroso — este desafio foca em identificar e corrigir esses problemas para que o container seja criado com sucesso.

---

## Dependências

Para executar o desafio localmente (sem usar `provision.sh`) você precisa dos seguintes componentes instalados e configurados:

- `terraform` (versão 1.0+ recomendada)
  - Instalação: https://developer.hashicorp.com/terraform/downloads
- `docker` (Docker Engine / daemon em execução)
  - Instalação: https://docs.docker.com/get-docker/
- `git` (para clonar o repositório)
- `curl` ou `wget` (opcional, para baixar artefatos)

Se for executar dentro do GitHub Codespaces ou de um Dev Container, verifique se o ambiente permite acesso ao daemon Docker (mount do socket `/var/run/docker.sock` ou Docker-in-Docker). Algumas políticas organizacionais podem bloquear o uso de containers privilegiados.

> Observação: as instruções abaixo mostram como rodar o fluxo manualmente, sem utilizar `provision.sh`.

---

## Passo a passo (manual)

1. Clone o repositório:

```bash
git clone https://github.com/gborgogno/hackaton-challenges.git
cd hackaton-challenges
```

2. Inicialize o Terraform (faça isso antes de validar/plannar):

```bash
terraform init
```

3. Valide o código (sintaxe e consistência):

```bash
terraform validate
```

4. Rode o plano para ver alterações propostas (sem aplicar):

```bash
terraform plan
```

5. Corrija `main.tf` localmente com seu editor preferido (ex.: VS Code, vim). Recomendamos manter um backup:

```bash
cp main.tf main.tf.bak
```

6. Repita `terraform validate` e `terraform plan` até não existirem erros.

7. Ao final, aplique as mudanças:

```bash
terraform apply -auto-approve
```

8. Verifique o container criado e os logs do Nginx:

```bash
docker ps --filter "name=nginx_hackaton"
docker logs nginx_hackaton
curl http://localhost:8080
```

Se você alterou a porta em `variables.tf`, use a porta configurada.

9. Para limpar os recursos:

```bash
terraform destroy -auto-approve
```

---

## Dicas rápidas (erros comuns neste exercício)

- `terrafom` → corrija para `terraform`
- `prowider` → `provider "docker" {}`
- `nome` → `name`
- `restart_policy` → `restart`
- Evite referenciar `output.` para definir portas antes do `apply` — outputs só existem depois do apply
- Ao referenciar uma imagem criada pelo recurso `docker_image`, prefira `.name` em muitas versões do provider

---

## Sobre `provision.sh`

O arquivo `provision.sh` existente é um helper que automatiza `terraform init`, `terraform validate`, `terraform plan` e `terraform apply`. Ele é útil para ambientes controlados, mas você não precisa usá-lo. As instruções deste README permitem executar cada etapa manualmente — é a opção recomendada quando você quer inspecionar resultados entre passos ou quando execução automática de scripts não é permitida.

Se quiser restaurar o arquivo original `main.tf`:

```bash
mv main.tf.bak main.tf
```

---

## Links úteis

- Repositório do desafio: https://github.com/gborgogno/hackaton-challenges
- Página com instruções e verificador (GitHub Pages): `docs/index.md` (se publicada)

---

Se quiser, eu atualizo também os comandos de `Makefile` ou adiciono um pequeno script `local_run.sh` com checagens seguras que não aplicam automaticamente (apenas `validate` e `plan`). Quer que eu crie esse helper? 
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
