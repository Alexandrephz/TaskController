# Task Controller

# PT-BR

Projeto de materia da faculdade impacta.

Esse projeto tem a finalidade de servir como um controle interno para empresas planejarem tarefas, dividindo por setores, com opcoes de feedbacks das atividades.

# Pre Requisitos
Docker instalado

# Starting
Clone esse repositorio git clone https://github.com/Alexandrephz/TaskController.git

Mude o campo "host" em  config/database.yml com o IP da sua maquina

# Development Environment

Construe e suba os containers: docker compose up --build

Construa o banco de dados: docker compose exec web rails db:create

Construa as tabelas: docker compose exec web rails db:migrate

Envie os dados iniciais: docker compose exec web rails db:seed

Compile os assets da aplicacao: docker compose exec web rails assets:precompile


# Acesso

Se estiver subindo em modo de desenvolvimento use http://127.0.0.1:3000
Use o usuario padrao: admin
Com a senha padrao: 123456

Pode alterar a senha do usuario padrao pelo http://127.0.0.1:3000/admin
