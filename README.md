# 🛠️ Desafio de Debug: Infraestrutura como Código (Terraform + Docker)

## 🚨 O Desafio

Seja bem-vindo ao desafio "Debug de IaC"!

Seu objetivo não é escrever infraestrutura, mas sim **consertá-la**. Você recebeu um arquivo `main.tf` que tenta provisionar um contêiner Docker Nginx simples, mas ele foi sabotado com vários erros de sintaxe, lógica e configuração.

O Terraform é rigoroso — este desafio foca em identificar e corrigir esses problemas para que o container seja criado com sucesso.

---

## Dependências

Para executar o desafio localmente você precisa dos seguintes componentes instalados e configurados:

- `terraform` (versão 1.0+ recomendada)
  - Instalação: https://developer.hashicorp.com/terraform/downloads
- `docker` (Docker Engine / daemon em execução)
  - Instalação: https://docs.docker.com/get-docker/
- `git` (para clonar o repositório)
- `curl` ou `wget` (opcional, para baixar artefatos)

Se for executar dentro do GitHub Codespaces ou de um Dev Container, verifique se o ambiente permite acesso ao daemon Docker (mount do socket `/var/run/docker.sock` ou Docker-in-Docker). Algumas políticas organizacionais podem bloquear o uso de containers privilegiados.

---

## Fluxo manual (passo a passo)

1. Clone o repositório:

```bash
git clone https://github.com/gborgogno/hackaton-challenges.git
cd hackaton-challenges
```

2. Inicialize o Terraform (faça isso antes de validar/planar):

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

## Critérios de sucesso

Para considerar o desafio completo, verifique os seguintes pontos:

- **Terraform apply:** `terraform apply -auto-approve` executa sem erros.
- **Container criado:** existe um container Docker com o nome `nginx_hackaton` (ver `docker ps`).
- **Nginx acessível:** o Nginx responde em `http://localhost:PORTA` (por padrão `8080`, ou conforme definido em `variables.tf`).
- **Logs válidos:** `docker logs nginx_hackaton` não mostra erros críticos (server boot OK).
- **Destruição limpa:** `terraform destroy -auto-approve` remove todos os recursos sem erros.

Dica: execute os comandos abaixo para checar rapidamente:

```bash
docker ps --filter "name=nginx_hackaton"
curl -fsS http://localhost:8080 || echo "Nginx não respondeu"
terraform destroy -auto-approve
```


## Executando no Codespaces (opcional)

Se você preferir usar GitHub Codespaces, crie um Codespace a partir deste repositório e execute os mesmos comandos listados acima no terminal do Codespace. Garanta que o Codespace tenha acesso ao daemon Docker (socket montado ou DinD) para que os containers possam ser criados.

---

## Observação final

Este repositório não requer execução automática via script — o fluxo manual é recomendado para inspeção entre etapas. Se quiser, eu posso adicionar um helper `local_run.sh` que roda apenas `terraform init && terraform validate && terraform plan` (sem aplicar) para facilitar verificações. Quer que eu crie esse helper?

---

## Links úteis

- Repositório do desafio: https://github.com/gborgogno/hackaton-challenges
- Página com instruções e verificador (GitHub Pages): `docs/index.md` (se publicada)

