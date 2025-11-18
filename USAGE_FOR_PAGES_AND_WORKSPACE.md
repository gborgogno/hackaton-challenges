# Publicação em GitHub Pages e Workspace (Codespaces / Dev Container)

Este arquivo descreve como a pasta `hackaton-challenges` foi preparada para publicação em GitHub Pages e para uso em um workspace (Dev Container / Codespaces).

## GitHub Pages

- O conteúdo público do desafio está em `hackaton-challenges/docs/`.
- Um workflow de Actions (`.github/workflows/deploy-pages.yml`) está configurado para publicar o conteúdo desta pasta no GitHub Pages quando houver push para a branch `main`.

Como usar:

1. Faça push para a branch `main`.
2. O workflow será acionado automaticamente e enviará `hackaton-challenges/docs` para o serviço de Pages.
3. Após o deploy, abra `Settings → Pages` no repositório para ver a URL publicada (ou aguarde a primeira execução do workflow e verifique o link de sucesso no job).

Observação: o workflow usa o caminho `hackaton-challenges/docs`. Se preferir que a pasta `docs/` esteja na raiz do repositório, mova o conteúdo ou ajuste o caminho no workflow.

## Workspace: Dev Container / Codespaces

- Há uma configuração de devcontainer em `.devcontainer/` que inclui:
  - `devcontainer.json` — instruções do container de desenvolvimento
  - `Dockerfile` — cria uma imagem com `terraform` e `docker` CLI instalados

Como usar:

1. Abra o repositório no GitHub e crie um Codespace (ou abra no VS Code e escolha "Reopen in Container").
2. O container será preparado conforme o `Dockerfile`.
3. No terminal do workspace:

```bash
cd hackaton-challenges
terraform init
terraform validate
terraform apply -auto-approve
```

Notas e limitações:

- O `Dockerfile` do devcontainer instala o cliente `docker` (CLI). Para que a criação de containers funcione, o daemon Docker precisa estar acessível ao devcontainer (por exemplo, montando `/var/run/docker.sock` do host). Em Codespaces, o suporte ao daemon do host pode variar.
- Se preferir, execute os comandos localmente em uma máquina com Docker instalado.

## Links rápidos

- Conteúdo do site: `hackaton-challenges/docs/index.md`
- Workflow Pages: `.github/workflows/deploy-pages.yml`
- Devcontainer: `.devcontainer/devcontainer.json` e `.devcontainer/Dockerfile`
