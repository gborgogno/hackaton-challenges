# Questões do Desafio (5)

1) Corrija o arquivo `variables.tf` para que a variável `container_port` tenha o tipo correto e possa ser usada sem erro. Explique sua correção.

2) No `main.tf` há um recurso com atributo escrito `nome` e uma referência a `docker_image.nginx_image.id`. Ajuste o recurso para usar os atributos esperados e justifique a mudança (`name` vs `nome`, `.id` vs `.name`).

3) O `outputs.tf` atual referencia `var.containerPort` (note a caixa). Ajuste o output para expor corretamente a porta configurada e descreva por que a diferença de nome causa falha.

4) No `providers.tf` raiz há um caminho para o socket Docker incorreto. Corrija o `provider` e explique duas formas de permitir que o Terraform crie containers via Docker no seu ambiente (local socket mount e DinD no Codespaces).

5) Opcional bônus: altere o `restart` do container para usar a política condicionada (ex.: só reiniciar em falhas). Atualize o `main.tf` e explique como testar localmente que a política foi aplicada.

Opções extras (pontos de avaliação):
- Adicione um `healthcheck` básico (via `local-exec` ou `null_resource`) que confirme que `http://localhost:<PORT>` responde com 200.

