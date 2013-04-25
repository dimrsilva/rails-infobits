# encoding: utf-8

Dado(/^que eu visite a página de um projeto$/) do
  @project = FactoryGirl.create('projects/project')
  visit projects_project_path @project.id
end
