# language: pt
Funcionalidade: Cadastro de Projetos

  Contexto:
    Dado que exista todos os registros para teste dos projetos
    E que eu esteja logado como o usuário "gerente1@test.com"

  Cenário: Acessando a lista de projetos
    Dado que eu visite a url "/projetos"
    Então eu devo ver uma tabela com 2 projetos
    E eu devo ver uma linha para o projeto "Projeto 1"
    E eu devo ver uma linha para o projeto "Projeto 3"
    E eu devo ver o link "Adicionar Projeto"

  Cenário: Acessando a página do Projeto 1
    Dado que eu visite a url "/projetos"
    Quando eu clicar no botão de visualizar o registro "Projeto 1"
    Então eu devo ver o link "Adicionar Tarefa"
    E eu devo ver o link "Editar Projeto"
    E eu devo ver uma lista com 2 tarefas
    E eu devo ver uma linha para a tarefa "Tarefa 1"
    E eu devo ver um botão de editar para o registro "Tarefa 1"
    E eu devo ver uma linha para a tarefa "Tarefa 2"
    E eu devo ver um botão de editar para o registro "Tarefa 2"

  Cenário: Acessando o formulário de uma tarefa
    Dado que eu visite a url "/projetos"
    Quando eu clicar no botão de visualizar o registro "Projeto 1"
    Então eu devo ver uma lista com 2 tarefas
    Quando eu clicar no botão de editar o registro "Tarefa 1"
    Então eu devo ver o botão "Atualizar Tarefa"
    E eu devo ver o link "Remover Tarefa"
