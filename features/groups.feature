# language: pt
Funcionalidade: Cadastro de Grupos
  Para registrar os grupos de contatos
  Como um administrador
  Eu quero ver a página de grupos

  Contexto:
    Dado que eu esteja logado como administrador

  @javascript
  Cenário: Deletar um grupo com contatos
    Dado que existam 3 contatos no grupo "Associado"
    E que eu visite a url "/contatos/grupos"
    Quando eu clicar no botão de deletar o registro "Associado"
    E eu confirmar a mensagem de alerta
    Então eu devo ver a mensagem "Impossível deletar pois existem contatos neste grupo"
