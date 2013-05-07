# language: pt
Funcionalidade: Cadastro de Contatos
  Como um administrador
  Para que eu edite as informações de um contato
  Eu quero acessar uma formulário de edição de contato

  Contexto:
    Dado que eu esteja logado como administrador

  @javascript
  Cenário: Eu devo ser capaz de selecionar um contato após começar a digitar seu nome
    Dado que exista um contato com nome "José Augusto"
    E que eu visite a url "/contatos/empresas/novo"
    Quando eu preencher o campo "Representante" com o valor "Jos"
    Então eu devo ver o texto "José Augusto"

  @javascript
  Cenário: Eu devo ser alertado caso tente apagar uma Pessoa cadastrada como representante de uma Empresa
    Dado que exista uma pessoa com nome "José Augusto"
    E que exista uma empresa com nome "Sapataria ABC"
    E que o representante de "Sapataria ABC" seja "José Augusto"
    E que eu visite a url "/contatos/pessoas"
    Quando eu clicar no botão de deletar o registro "José Augusto"
    E eu confirmar a mensagem de alerta
    Então eu devo ver a mensagem "Impossível deletar pois essa pessoa é representante em alguma empresa"
