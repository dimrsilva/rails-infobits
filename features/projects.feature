# language: pt
Funcionalidade: Cadastro de Projetos
  Para controlar os projetos desenvolvidos
  Como um administrador
  Eu quero ver a página de projetos

  Contexto:
    Dado que eu esteja logado como administrador

  Cenário: Acessando uma página de projeto
    Dado que eu visite a página de um projeto
    Então eu não devo ver um formulário de projeto
    E eu devo ver um resumo do projeto
    E eu devo ver o link "Editar Projeto"
    E eu devo ver o link "Remover Projeto"
