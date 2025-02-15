# Desafio técnico e-commerce

## Instalar Docker compose v2
- sudo apt-get install docker-compose-plugin

## Instalar Make
- sudo apt-get install make

# Comandos configurados no make

## make build
- Para fazer o build do projeto

## make docker
- Iniciar o servidor

## make debug
- Para quando utilizar o byebug no codigo

## make sidekiq
- Inicia o servico do sidekiq, que ira rodar os jobs agendados

## make bash
- Permite acesso ao bash do container

# Como rodar os testes
- make bash
- RAILS_ENV=test bundle exec rspec spec/ -f p

