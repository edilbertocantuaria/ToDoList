# To Do List

Aplicacao de lista de tarefas com front-end React e API Rails, organizada em uma unica raiz de projeto para desenvolvimento local com Docker.

Este repositorio e composto por:

1. `web/`: interface React responsiva para login, listas, tarefas e tags.
2. `api/`: API Rails responsavel por autenticacao, persistencia e regras de negocio.
3. `docker-compose.yml`: orquestracao local com `db`, `api` e `web`.

## Visao Geral

Fluxo principal:

1. Usuario acessa o front-end em `web/`.
2. O front-end autentica o usuario e salva o token recebido da API.
3. O front chama a API para listar, criar, editar e remover task lists, tasks e tags.
4. A API valida a requisicao, aplica as regras de negocio e persiste os dados no PostgreSQL.
5. O usuario visualiza o estado atualizado sem precisar sair da interface.

## Arquitetura

```text
Browser
	 |
	 | HTTP
	 v
Web Container (React)
	 |
	 | HTTP interno
	 v
API Container (Rails)
	 |
	 | PostgreSQL
	 v
Database Container
```

## Stack Tecnologica

- Front-end: React 18, React Router, Axios, Material UI, Styled Components.
- Back-end: Ruby on Rails 7.2, JSON API, autenticao via token JWT.
- Banco: PostgreSQL.
- Infra: Docker e Docker Compose.

## Estrutura do Projeto

- `web/`
	- aplicacao React
	- codigo-fonte em `web/src`
	- configuracoes do front em `web/package.json`
- `api/`
	- aplicacao Rails
	- controllers, models e services em `api/app`
	- configuracoes do Rails em `api/config`
- `docker-compose.yml`
	- sobe os tres servicos locais
- `.env.example`
	- exemplo de variaveis de ambiente da raiz

## Pre-requisitos

1. Docker e Docker Compose.
2. Node.js e npm, caso queira rodar o front fora do Docker.
3. Ruby e Bundler, caso queira rodar a API fora do Docker.
4. PostgreSQL, caso queira rodar a API fora do Docker.

## Setup Rapido com Docker

1. Crie o arquivo de ambiente na raiz:

```bash
copy .env.example .env
```

No PowerShell:

```powershell
Copy-Item .env.example .env
```

2. Se quiser alterar os valores padrao, ajuste no `.env`:

- `DB_USERNAME`
- `DB_PASSWORD`
- `DB_PORT`
- `DEVELOPMENT_DATABASE`
- `TEST_DATABASE`
- `REACT_APP_API_URL`

3. Suba os servicos:

```bash
docker compose up --build
```

4. Acesse:

- Web: http://localhost:3001
- API: http://localhost:3000
- Health check: http://localhost:3000/up

## Como Funciona o Docker

O compose sobe tres containers:

1. `db`: PostgreSQL com volume persistente.
2. `api`: Rails apontando para o banco `db`.
3. `web`: React consumindo a API pela variavel `REACT_APP_API_URL`.

O front usa `http://localhost:3000` por padrao em desenvolvimento local.

## Usuarios de Teste (Desenvolvimento)

Para facilitar o primeiro login, o projeto possui usuarios de seed para ambiente de desenvolvimento:

1. Email: `joao@example.com`
	Senha: `password123`
2. Email: `maria@example.com`
	Senha: `password456`

Se os usuarios ainda nao existirem no banco, execute:

```bash
docker compose exec api bundle exec rails db:seed
```

## Variaveis de Ambiente

### Raiz

Arquivo: `.env`

- `DB_USERNAME`: usuario do PostgreSQL.
- `DB_PASSWORD`: senha do PostgreSQL.
- `DB_PORT`: porta exposta do banco.
- `DEVELOPMENT_DATABASE`: nome do banco de desenvolvimento.
- `TEST_DATABASE`: nome do banco de testes.
- `REACT_APP_API_URL`: URL base da API usada pelo front.

### API

Arquivo: `api/.env.example`

- `DB_USERNAME`
- `DB_PASSWORD`
- `DB_PORT`
- `DEVELOPMENT_DATABASE`
- `TEST_DATABASE`
- `DATABASE_URL` quando quiser apontar para um banco remoto.

### Web

Arquivo: `web/.env.example`

- `REACT_APP_API_URL`

## Rodando Sem Docker

### API

```bash
cd api
bundle install
bundle exec rails db:create db:migrate
bundle exec rails server
```

### Web

```bash
cd web
npm install
npm start
```

## Comandos Uteis

### API

```bash
cd api
bundle exec rails test
bundle exec rails db:prepare
bundle exec rails routes
```

### Web

```bash
cd web
npm run build
npm run lint
```

### Docker

```bash
docker compose up --build
docker compose down
docker compose logs -f api
docker compose logs -f web
```

## Testes

### Backend

```bash
cd api
bundle exec rails test
```

### Frontend

```bash
cd web
npm run lint
```

## Documentacao por Modulo

- Backend: [api/README.md](api/README.md)
- Frontend: [web/README.md](web/README.md)
- Guia de endpoints da API: [api/doc/usage.md](api/doc/usage.md)

## Documentacao da API

A documentacao detalhada dos endpoints, payloads, regras de negocio e exemplos de resposta esta em [api/doc/usage.md](api/doc/usage.md).

## Troubleshooting

1. Front nao consegue acessar a API: confirme `REACT_APP_API_URL` e se o container `api` esta no ar.
2. Erro de banco no backend: confira `DB_USERNAME`, `DB_PASSWORD` e o status do container `db`.
3. Aplicacao nao sobe no Docker: rode `docker compose logs -f api` e `docker compose logs -f web` para ver o ponto exato da falha.

