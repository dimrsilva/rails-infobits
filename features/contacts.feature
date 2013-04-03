# language: pt


Funcionalidade: Cadastro de Contatos
  Para obter informações de contatos
  Como um administrador
  Eu quero ver a página de contatos

  Contexto:
    Dado que eu esteja logado como administrador

  Cenário: Acessar página de contatos
    Dado que eu visite a url /contatos
    Então eu devo ver "Contatos" no título

  Cenário: Acessar contatos organizados por páginas
    Dado que existam 15 contatos cadastrados
    E que eu visite a url /contatos
    Então eu devo ver um link para a segunda página