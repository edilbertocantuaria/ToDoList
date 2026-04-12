# To Do List

Aplicação de lista de tarefas com front-end React e API Rails, organizada em uma única raiz de projeto para desenvolvimento local com Docker.

Este repositório é composto por:

1. `web/`: interface React responsiva para login, listas, tarefas e tags.
2. `api/`: API Rails responsável por autenticação, persistência e regras de negócio.
3. `docker-compose.yml`: orquestração local com `db`, `api` e `web`.

## Visão Geral

Fluxo principal:

1. Usuário acessa o front-end em `web/`.
2. O front-end autentica o usuário e salva o token recebido da API.
3. O front chama a API para listar, criar, editar e remover task lists, tasks e tags.
4. A API valida a requisição, aplica as regras de negócio e persiste os dados no PostgreSQL.
5. O usuário visualiza o estado atualizado sem precisar sair da interface.

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

## Stack Tecnológica

- Front-end: React 18, React Router, Axios, Material UI, Styled Components.
- Back-end: Ruby on Rails 7.2, JSON API, autenticação via token JWT.
- Banco: PostgreSQL.
- Infra: Docker e Docker Compose.

## Estrutura do Projeto

- `web/`
  - aplicação React
  - código-fonte em `web/src`
  - configurações do front em `web/package.json`
- `api/`
  - aplicação Rails
  - controllers, models e services em `api/app`
  - configurações do Rails em `api/config`
- `docker-compose.yml`
  - sobe os três serviços locais
- `.env.example`
  - exemplo de variáveis de ambiente da raiz

## Pré-requisitos

1. Docker e Docker Compose.
2. Node.js e npm, caso queira rodar o front fora do Docker.
3. Ruby e Bundler, caso queira rodar a API fora do Docker.
4. PostgreSQL, caso queira rodar a API fora do Docker.

## Setup Rápido com Docker

1. Crie o arquivo de ambiente na raiz:

```bash
copy .env.example .env
```

No PowerShell:

```powershell
Copy-Item .env.example .env
```

2. Se quiser alterar os valores padrão, ajuste no `.env`:

- `DB_USERNAME`
- `DB_PASSWORD`
- `DB_PORT`
- `DEVELOPMENT_DATABASE`
- `TEST_DATABASE`
- `REACT_APP_API_URL`

3. Suba os serviços:

```bash
docker compose up --build
```

4. Acesse:

- Web: http://localhost:3001
- API: http://localhost:3000
- Health check: http://localhost:3000/up

## Como Funciona o Docker

O compose sobe três containers:

1. `db`: PostgreSQL com volume persistente.
2. `api`: Rails apontando para o banco `db`.
3. `web`: React consumindo a API pela variável `REACT_APP_API_URL`.

O front usa `http://localhost:3000` por padrão em desenvolvimento local.

## Usuários de Teste (Desenvolvimento)

Para facilitar o primeiro login, o projeto possui usuários de seed para ambiente de desenvolvimento:

1. Email: `joao@example.com`
   Senha: `password123`
2. Email: `maria@example.com`
   Senha: `password456`

Se os usuários ainda não existirem no banco, execute:

```bash
docker compose exec api bundle exec rails db:seed
```

## Variáveis de Ambiente

### Raiz

Arquivo: `.env`

- `DB_USERNAME`: usuário do PostgreSQL.
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

## Comandos Úteis

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

## Documentação por Módulo

- Backend: [api/README.md](api/README.md)
- Frontend: [web/README.md](web/README.md)
- Guia de endpoints da API: [api/doc/usage.md](api/doc/usage.md)

## Documentação da API

A documentação detalhada dos endpoints, payloads, regras de negócio e exemplos de resposta está em [api/doc/usage.md](api/doc/usage.md).

## Solução de Problemas

1. Front não consegue acessar a API: confirme `REACT_APP_API_URL` e se o container `api` está no ar.
2. Erro de banco no backend: confira `DB_USERNAME`, `DB_PASSWORD` e o status do container `db`.
3. Aplicação não sobe no Docker: rode `docker compose logs -f api` e `docker compose logs -f web` para ver o ponto exato da falha.

