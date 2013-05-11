# encoding: utf-8

Dado(/^que eu visite a página de um projeto$/) do
  @project = FactoryGirl.create('projects/project')
  visit projects_project_path @project.id
end

Dado %r/^que exista todos os registros para teste dos projetos$/ do
  group_c = FactoryGirl.create 'contact/group', :acts_as_colaborator => true
  group_m = FactoryGirl.create 'contact/group', :acts_as_project_manager => true
  group_d = FactoryGirl.create 'contact/group', :acts_as_project_director => true

  @c1 = FactoryGirl.create 'contact/person', :firstname => 'Colaborador 1'
  @c1.groups << group_c
  @c1.save
  @uc1 = FactoryGirl.create 'admin/user', :email => 'colaborador1@test.com', :contact => @c1
  @c2 = FactoryGirl.create 'contact/person', :firstname => 'Colaborador 2'
  @c2.groups << group_c
  @c2.save
  @uc2 = FactoryGirl.create 'admin/user', :email => 'colaborador2@test.com', :contact => @c2
  @c3 = FactoryGirl.create 'contact/person', :firstname => 'Colaborador 3'
  @c3.groups << group_c
  @c3.save
  @uc3 = FactoryGirl.create 'admin/user', :email => 'colaborador3@test.com', :contact => @c3

  @m1 = FactoryGirl.create 'contact/person', :firstname => 'Gerente 1'
  @m1.groups << group_m
  @m1.save
  @um1 = FactoryGirl.create 'admin/user', :email => 'gerente1@test.com', :contact => @m1
  @m2 = FactoryGirl.create 'contact/person', :firstname => 'Gerente 2'
  @m2.groups << group_m
  @m2.save
  @um2 = FactoryGirl.create 'admin/user', :email => 'gerente2@test.com', :contact => @m2

  @d1 = FactoryGirl.create 'contact/person', :firstname => 'Diretor 1'
  @d1.groups << group_d
  @d1.save
  @ud1 = FactoryGirl.create 'admin/user', :email => 'diretor1@test.com', :contact => @d1

  @p1 = FactoryGirl.create 'projects/project',
    :title => 'Projeto 1',
    :manager => @m1,
    :colaborators => [@c1, @c2, @c3]
  @p2 = FactoryGirl.create 'projects/project',
    :title => 'Projeto 2',
    :manager => @m2,
    :colaborators => [@c1, @c3]
  @p3 = FactoryGirl.create 'projects/project',
    :title => 'Projeto 3',
    :manager => @m1,
    :colaborators => [@c3]

  @p1t1 = FactoryGirl.create 'projects/task', :title => 'Tarefa 1', :project => @p1, :responsible => @c1
  @p1t2 = FactoryGirl.create 'projects/task', :title => 'Tarefa 2', :project => @p1, :responsible => @c2

  @p2t1 = FactoryGirl.create 'projects/task', :title => 'Tarefa 1', :project => @p2, :responsible => @c3
end

Então %r/^eu devo ver uma lista com (\d+) tarefas$/ do |qtd|
  @grouptag = '.content .view>ul'
  @rowtag = 'li'
  page.find(@grouptag).all(@rowtag).count.should eql qtd.to_i
end
