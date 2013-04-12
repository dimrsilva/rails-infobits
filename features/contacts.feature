# language: pt
Funcionalidade: Cadastro de Contatos
  Para obter informações de contatos
  Como um administrador
  Eu quero ver a página de contatos

  Contexto:
    Dado que eu esteja logado como administrador

  Cenário: Acessar página de contatos
    Dado que eu visite a url "/contatos"
    Então eu devo ver "Contatos" no título
    E eu devo ver o link "Adicionar Pessoa Física"
    E eu devo ver o link "Adicionar Pessoa Jurídica"
    E eu devo ver o menu "Contatos"
    E eu devo ver o menu "Projetos"
    E eu devo ver o menu "Grupos"

  Cenário: Acessar contatos organizados por páginas
    Dado que existam 15 contatos cadastrados
    E que eu visite a url "/contatos"
    Então eu devo ver um link para a 2º página

  @javascript
  Cenário: Utilizar auto-completar do campo de Contatos
    Dado que exista um contato com nome "José Augusto"
    E que eu visite a url "/contatos/pessoas_juridicas/new"
    Quando eu preencher o campo "Representante" com o valor "Jos"
    Então eu devo ver o texto "José Augusto"