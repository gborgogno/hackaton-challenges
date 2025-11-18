---
title: Desafio Debug IaC — Passo a passo
---

# Desafio: Debug IaC (Terraform + Docker)

Bem-vindo ao desafio de depuração. Esta página contém o passo a passo, critérios de sucesso e um verificador interativo (client-side) para ajudar a encontrar erros comuns no `main.tf` fornecido.

**Repositório do desafio:** https://github.com/gborgogno/hackaton-challenges

**Abrir no Codespaces (recomendado para execução):**

https://github.com/codespaces/new?repo=gborgogno/hackaton-challenges

---

## Objetivo

Consertar o `main.tf` quebrado para que um container Nginx (`nginx_hackaton`) seja criado e acessível em `http://localhost:8080` (ou na porta definida em `variables.tf`).

## Passo a passo (rápido)

1. Clone o repositório:

```bash
git clone https://github.com/gborgogno/hackaton-challenges.git
cd hackaton-challenges
```

2. Inspecione o arquivo `main.tf` e rode validação localmente (se tiver Docker + Terraform):

```bash
terraform init
terraform validate
terraform plan
```

3. Corrija os erros no `main.tf` (veja dicas abaixo) e rode `terraform plan` até não haver erros.

4. Quando estiver OK, execute:

```bash
terraform apply -auto-approve
```

5. Verifique que o container `nginx_hackaton` está rodando e que `http://localhost:8080` responde.

6. Finalize com:

```bash
terraform destroy -auto-approve
```

## Critérios de sucesso

- `terraform apply` executa com sucesso
- Existe um container chamado `nginx_hackaton` executando
- O Nginx responde em `http://localhost:PORTA` (porta configurada em `variables.tf`, por padrão `8080`)
- `terraform destroy` remove os recursos sem erro

---

## Dicas rápidas (erros mais comuns neste exercício)

- Erro de digitação em `terraform` block: `terrafom` → `terraform`
- Provider mal escrito: `prowider` → `provider "docker" {}`
- Atributos com nomes errados: `keep_local` → `keep_locally` ou `keep_local` conforme versão (use a documentação do provider)
- Nome de atributo `nome` → `name`
- `restart_policy` → `restart` (o provider usa `restart`)
- Não referencie outputs enquanto eles ainda não existem (evite `output.container_port.value` como porta externa)

---

## Verificador interativo (dicas instantâneas)

Edite o `main.tf` abaixo (ou cole o conteúdo) e clique em **Verificar** — o verificador client-side procura por padrões/typos conhecidos e fornece sugestões. Isto é apenas um auxílio: rode `terraform validate` em seguida.

<textarea id="code" style="width:100%;height:280px;">terrafom {
  required_providers {
    docker-provider = {
      source = "hashicorp/docker"
      version = "~> 3.0"
    }
  }
}

prowider "docker" {}

resource "docker_image" "nginx_image" {
  name         = "nginx:latest"
  keep_local = false
}

resource "docker_container" "nginx_hackathon" {
  image = docker_image.nginx_image.id
  nome  = "nginx_hackaton"
  ports {
    internal = 80
    external = output.container_port.value
  }
  restart_policy "always"
}

output "container_port" {
  value = docker_container.nginx_hackaton.ports.0.public_port
}
</textarea>

<div style="margin:8px 0">
  <button id="check">Verificar</button>
  <button id="load-repo">Carregar arquivo do repositório</button>
  <button id="copy-solution">Mostrar solução sugerida</button>
</div>

<div id="hints" style="white-space:pre-wrap;background:#f6f8fa;border:1px solid #ddd;padding:12px;min-height:80px"></div>

<script>
function findAll(regex, str){
  const r = str.match(regex);
  return r || [];
}

function check(text){
  const hints = [];
  if (/terrafom/.test(text)) hints.push('- Encontrado "terrafom" → corrija para "terraform"');
  if (/prowider/.test(text)) hints.push('- Encontrado "prowider" → use `provider "docker" {}`');
  if (/keep_local/.test(text)) hints.push('- Encontrado "keep_local" → verifique o nome do atributo (`keep_locally` / `keep_local` depende da versão do provider)');
  if (/\bnome\b/.test(text)) hints.push('- Encontrado "nome" → corrija para `name`');
  if (/restart_policy/.test(text)) hints.push('- Encontrado "restart_policy" → o atributo correto é `restart`');
  if (/output\./.test(text)) hints.push('- Evite usar `output.` para definir portas. Outputs só existem após apply — defina a porta diretamente ou use variável.');
  if (/docker_image\.nginx_image\.id/.test(text)) hints.push('- Ao referenciar imagem para `docker_container`, prefira `.name` em vez de `.id` se a imagem for um recurso local (dependendo do provider).');
  if (hints.length===0) hints.push('Nenhum erro óbvio detectado pelo verificador simples. Rode `terraform validate` para validação completa.');
  return hints.join('\n');
}

document.getElementById('check').addEventListener('click', ()=>{
  const txt = document.getElementById('code').value;
  document.getElementById('hints').textContent = check(txt);
});

document.getElementById('load-repo').addEventListener('click', async ()=>{
  try{
    const resp = await fetch('https://raw.githubusercontent.com/gborgogno/hackaton-challenges/main/main.tf');
    if(!resp.ok) throw new Error('Arquivo não encontrado no repositório');
    const t = await resp.text();
    document.getElementById('code').value = t;
    document.getElementById('hints').textContent = 'Carregado main.tf do repositório (branch main)';
  }catch(e){ document.getElementById('hints').textContent = String(e); }
});

document.getElementById('copy-solution').addEventListener('click', ()=>{
  const solution = `terraform {
  required_providers {
    docker = { source = "hashicorp/docker" }
  }
}

provider "docker" {}

resource "docker_image" "nginx_image" {
  name = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx_hackathon" {
  name  = "nginx_hackaton"
  image = docker_image.nginx_image.name
  ports { internal = 80  external = 8080 }
  restart = "always"
}

output "container_port" { value = 8080 }
`;
  document.getElementById('code').value = solution;
  document.getElementById('hints').textContent = 'Solução sugerida (ajuste conforme necessidade)';
});

</script>

---