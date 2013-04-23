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
    E eu devo ver o link "Adicionar Pessoa"
    E eu devo ver o link "Adicionar Empresa"
    E eu devo ver o menu "Contatos"
    E eu devo ver o menu "Projetos"
    E eu devo ver o menu "Administração"

  Cenário: Acessar contatos organizados por páginas
    Dado que existam 15 contatos cadastrados
    E que eu visite a url "/contatos"
    Então eu devo ver um link para a 2º página

  @javascript
  Cenário: Utilizar auto-completar do campo de Contatos
    Dado que exista um contato com nome "José Augusto"
    E que eu visite a url "/contatos/empresas/new"
    Quando eu preencher o campo "Representante" com o valor "Jos"
    Então eu devo ver o texto "José Augusto"

  @javascript
  Cenário: Deletar uma pessoa que seja cadastrada como representante em alguma empresa
    Dado que exista uma pessoa com nome "José Augusto"
    E que exista uma empresa com nome "Sapataria ABC"
    E que o representante de "Sapataria ABC" seja "José Augusto"
    E que eu visite a url "/contatos/pessoas"
    Quando eu clicar no botão de deletar o registro "José Augusto"
    E eu confirmar a mensagem de alerta
    Então eu devo ver a mensagem "Impossível deletar pois essa pessoa é representante em alguma empresa"
