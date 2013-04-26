# language: pt
Funcionalidade: Cadastro de Contatos
  Como um administrador
  Para que eu possa obter as informações de contatos
  Eu quero acessar uma lista de contatos

  Contexto:
    Dado que eu esteja logado como administrador

  Cenário: Eu devo ser capaz de inserir novos contatos
    Dado que eu visite a url "/contatos"
    Então eu devo ver "Contatos" no título
    E eu devo ver o link "Adicionar Pessoa"
    E eu devo ver o link "Adicionar Empresa"

  Cenário: A lista deve ser paginada em 10 itens
    Dado que existam 15 contatos cadastrados
    E que eu visite a url "/contatos"
    Então eu devo ver um link para a 2º página
