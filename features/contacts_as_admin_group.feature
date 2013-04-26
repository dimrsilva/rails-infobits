# language: pt
Funcionalidade: Cadastro de Contatos
  Como um administrador
  Para que haja uma melhor organização dos contatos
  Eu quero categorizar os contatos em grupos

  Contexto:
    Dado que eu esteja logado como administrador

  Cenário: Eu devo ser capaz de selecionar a quais grupos um contato pertence
    Dado que exista um grupo com nome "Cliente"
    E que exista um grupo com nome "Colaborador"
    E que eu visite a url "/contatos/pessoas/new"
    Então eu devo ver o um checkbox com o valor "Cliente"
    E eu devo ver o um checkbox com o valor "Colaborador"
